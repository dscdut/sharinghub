import { AbstractInputValidatorInterceptor } from './input-validator.interceptor';

export class DefaultValidatorInterceptor extends AbstractInputValidatorInterceptor {
    /**
      * @type {import('joi').ObjectSchema<TSchema>} schema
      */
    schema;

    /**
      * @param {import('joi').ObjectSchema<TSchema>} schema
      */
    constructor(schema) {
        super();
        this.schema = schema;
    }

    /**
     * @override getSchema
     * @implements default we no need to change schema based on request
     */
    // eslint-disable-next-line no-unused-vars
    getSchema(req) {
        return this.schema;
    }

    getValueToValidate(req) {
        switch (req.method) {
            case 'POST':
            case 'PUT':
            case 'PATCH':
            case 'DELETE':
                return req.body;
            case 'GET':
            default:
                return req.query;
        }
    }
}
