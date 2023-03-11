/* eslint-disable no-unused-vars */
import { responseJoiError } from 'core/utils';

export class AbstractInputValidatorInterceptor {
    /**
      * @return {import('joi').ObjectSchema<TSchema>} schema
      * @param {string} req need when schema will be defined based on request data
      * Schema to be validate
      */
    getSchema(req) { throw new Error(`${AbstractInputValidatorInterceptor.name}  need to implement getSchema`); }

    /**
     * @returns return value get from request to be validated
     */
    getValueToValidate(req) { throw new Error(`${AbstractInputValidatorInterceptor.name} need to implement getValueToValidate`); }

    /**
     * @returns error handler of joi. Base handler is the utility function responseJoiError
     */
    getResponseErrorHandler(res, error) { return responseJoiError(res, error); }

    intercept = async (req, res, next) => {
        try {
            await this.getSchema(req).validateAsync(this.getValueToValidate(req), { abortEarly: false });
            return next();
        } catch (error) {
            return this.getResponseErrorHandler(res, error);
        }
    };
}
