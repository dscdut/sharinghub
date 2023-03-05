// @ts-check
/**
 * @typedef {keyof SwaggerDocument.type} DocumentType
 */

export class SwaggerDocument {
    static DEFAULT_GENERATOR = 'string';

    static PRIMITIVE_TYPES = ['string', 'int', 'dateTime', 'bool'];

    static type = {
        string: {
            type: 'string',
        },
        int: {
            type: 'integer',
            format: 'int64',
        },
        dateTime: {
            type: 'string',
            format: 'date-time',
        },
        bool: {
            type: 'boolean',
            default: true,
        },
        file: {
            type: 'file',
        },
        object: {
            type: 'object',
        },
        array: (item, params = {}) => {
            if (SwaggerDocument.PRIMITIVE_TYPES.includes(item)) {
                return {
                    type: 'array',
                    items: {
                        ...SwaggerDocument.type[item],
                        ...params
                    }
                };
            }
            return {
                type: 'array',
                items: {
                    $ref: `#/components/schemas/${item}`,
                }
            };
        },
        enum: (enumModel, params = {}) => ({
            type: 'string',
            enum: Object.values(enumModel),
            ...params
        }),
        model: (dtoModel, params = {}) => ({
            $ref: `#/components/schemas/${dtoModel}`,
            ...params
        }),
    };

    /**
     *
     * @param {{type: DocumentType, model: string, required: boolean, readOnly: boolean, example: string}} options
     * @returns
     */
    static ApiProperty(options) {
        const {
            type,
            model = SwaggerDocument.DEFAULT_GENERATOR,
            required = true,
            readOnly = false,
            example,
        } = options;
        let swaggerType;
        if (type === 'enum'
            || type === 'model'
            || type === 'array') {
            swaggerType = SwaggerDocument.type[type](model, { example });
        } else {
            swaggerType = SwaggerDocument.type[type];
        }

        return {
            required,
            example,
            readOnly,
            ...swaggerType,
        };
    }

    /**
     *
     * @param {{type?: DocumentType, model?: string, required?: boolean, readOnly?: boolean, example?: string, name?: string, paramsIn?: string, description?: string}} options
     * @returns
     */
    static ApiParams(options) {
        const {
            type,
            name,
            model,
            paramsIn = 'query',
            required = true,
            example,
            description
        } = options;

        let swaggerType;

        if (type === 'enum'
            || type === 'model'
            || type === 'array') {
            swaggerType = SwaggerDocument.type[type](model, { example });
        } else {
            swaggerType = SwaggerDocument.type[type];
        }

        return {
            name,
            in: paramsIn,
            schema: swaggerType,
            required,
            example,
            description
        };
    }

    static extractParam(route) {
        const params = [];
        route.split('/').forEach(el => {
            if (el.startsWith(':')) {
                const pattern = el.split(':')[1];
                params.push({
                    name: pattern,
                    in: 'path',
                    schema: {
                        type: 'integer',
                        format: 'int64',
                    },
                    required: true,
                });
            }
        });
        return params;
    }
}
