import { SwaggerDocument } from '../../../packages/swagger';

export const WardQuery = SwaggerDocument.ApiParams({
    name: 'ward',
    paramsIn: 'query',
    type: 'string',
    required: false,
    description: 'Ward/commune name to look up campaigns in the area',
});
