import express from 'express';
import { UnAuthorizedException } from 'packages/httpException';
import { getUserContext } from 'packages/authModel/module/user';
import { SwaggerContentDto } from 'packages/swagger/model/SwaggerContentDto';
import { SwaggerContentCreator } from 'packages/swagger/core/content';
import { ForbiddenException } from 'packages/httpException/ForbiddenException';
import { logger } from '../logger';
import { ArgumentRequired } from './exceptions/ArgumentRequired';
import { HttpException } from '../httpException/HttpException';
import { MethodRequired } from './exceptions/MethodRequired';
import { HttpResponse } from './response/http.response';
import { InValidHttpResponse } from './response/invalidHttp.response';

export class Module {
    static logger = logger;

    /**
     * @type {
    [
        {
            route,
            controller,
            method,
            middlewares,
            preAuthorization,
            description,
            model?:any,
            params?: any
        }
    ]
    } content
     */
    #swaggerContent = [];

    /**
     * @type {
        {
            prefixPath,
            tag,
            module
        }
    }
     */
    #prefix;

    #router = express.Router();

    static builder() {
        return new Module();
    }

    static #producePreAuthorizeMiddleware = (req, res, next) => {
        if (!getUserContext(req)) {
            return next(new UnAuthorizedException());
        }
        return next();
    };

    static #produceGuard = guardClass => {
        if (!guardClass.canActive) {
            throw new MethodRequired(guardClass.constructor.name, 'canActive');
        }
        return async (req, res, next) => {
            let canActive;

            try {
                canActive = await guardClass.canActive(req);
            } catch (error) {
                return next(error);
            }

            if (!canActive) {
                if (guardClass.getMessage) {
                    return next(new ForbiddenException(guardClass.getMessage()));
                }
                return next(new ForbiddenException('You do not have permission to do this action! Please contact admin about this'));
            }

            return next();
        };
    };

    static #produceInterceptor = interceptorClass => {
        if (!interceptorClass['intercept']) {
            throw new MethodRequired(interceptorClass.constructor.name, 'intercept');
        }
        return interceptorClass.intercept;
    };

    #createHandler = controller => async (request, response) => {
        try {
            const data = await controller(request);
            if (!(data instanceof HttpResponse)) {
                return InValidHttpResponse.toInternalResponse(
                    `${data.constructor.name} is not instance of HttpResponse.`
                        + 'Should use HttpResponse to build http response',
                ).toResponse(response);
            }
            return data.toResponse(response);
        } catch (err) {
            if (err instanceof HttpException) {
                return new InValidHttpResponse(err.status, err.code, err.message).toResponse(response);
            }
            Module.logger.error(err.message);
            return InValidHttpResponse.toInternalResponse(err.message).toResponse(response);
        }
    };

    /**
     * @param {
        {
            route,
            controller,
            method,
            middlewares,
            preAuthorization,
            description,
            model?:any,
            params?: any
        }
    } content
     */
    #addSwaggerContent = content => {
        const jsonContent = SwaggerContentDto(content);

        this.#swaggerContent.push(
            SwaggerContentCreator.builder().fromJson(jsonContent).addPrefix(this.#prefix).build(),
        );
    };

    addPrefix({ prefixPath = '/', tag, module }) {
        if (!module) {
            throw new ArgumentRequired('module', 'addPrefix function');
        }
        this.#prefix = {
            prefixPath,
            tag,
            module,
        };
        return this;
    }

    /**
     * @param {
        [{
            route: string,
            controller: any,
            method: 'get' | 'post' | 'update' | 'patch' | 'delete',
            interceptors?: [],
            guards?: [],
            preAuthorization?: boolean,
            description?: string,
            model?:any,
            params?: any
        }]
     } apis
     */
    register(apis) {
        Module.logger.info(`[${this.#prefix.module}] is bundling`);

        apis.forEach(api => {
            const {
                route, controller, method, interceptors, preAuthorization, guards
            } = api;
            const middlewares = [];

            if (preAuthorization) {
                middlewares.push(Module.#producePreAuthorizeMiddleware);
            }

            if (interceptors?.length > 0) {
                interceptors.forEach(interceptor => {
                    middlewares.push(Module.#produceInterceptor(interceptor));
                });
            }

            if (guards?.length > 0) {
                guards.forEach(guard => {
                    middlewares.push(Module.#produceGuard(guard));
                });
            }

            if (!controller) {
                throw new Error(
                    `${this.#prefix.module} with ${method.toUpperCase()} ${
                        this.#prefix.prefixPath
                    }${route} can not mapping controller`,
                );
            }

            this.#router[method](route, ...middlewares, this.#createHandler(controller));

            Module.logger.info(
                `[${this.#prefix.module}] ${method.toUpperCase()} ${this.#prefix.prefixPath}${route} mapped ${
                    controller.name
                }`,
            );

            this.#addSwaggerContent(api);
        });
        return this;
    }

    build(globalRoute) {
        globalRoute.use(this.#prefix.prefixPath, this.#router);
    }

    /**
     * @notes this function will be triggered whenever handler resolver is registered
     * @param {import('../swagger/core/core').SwaggerBuilder} swaggerInstance
     */
    buildSwagger(swaggerInstance) {
        swaggerInstance.addTag(this.#prefix.tag);
        this.#swaggerContent.forEach(content => {
            swaggerInstance.api(content);
        });
    }
}
