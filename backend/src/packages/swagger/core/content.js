import { SwaggerDocument } from './document';

export class SwaggerContentCreator {
    #rawContent;

    #prefixRoute;

    static builder() {
        return new SwaggerContentCreator();
    }

    #toRouteSwagger = () => {
        const fullRoute = this.#prefixRoute.prefixPath === '/' ? this.#rawContent.route : `${this.#prefixRoute.prefixPath}${this.#rawContent.route}`;

        return fullRoute
            .split('/')
            .map(el => {
                if (el.startsWith(':')) {
                    return `${el.replace(':', '{')}}`;
                }
                return el;
            })
            .join('/');
    };

    #toParams = () => {
        const autoGenParams = SwaggerDocument.extractParam(this.#rawContent.route);
        if (!this.#rawContent.params || this.#rawContent.params.length === 0) {
            return [...autoGenParams];
        }

        return [...this.#rawContent.params];
    };

    fromJson(rawContent) {
        this.#rawContent = rawContent;
        return this;
    }

    addPrefix(prefix) {
        if (!prefix.prefixPath || !prefix.tag || !prefix.module) {
            throw new Error(`Prefix of ${SwaggerContentCreator.name} should contains fields: prefixPath, tag, module`);
        }
        this.#prefixRoute = {
            prefixPath: prefix.prefixPath,
            tag: prefix.tag,
            module: prefix.module,
        };
        return this;
    }

    build() {
        this.#rawContent.params = this.#toParams();
        this.#rawContent.route = this.#toRouteSwagger();
        this.#rawContent.tags = [this.#prefixRoute.tag];
        return this.#rawContent;
    }
}
