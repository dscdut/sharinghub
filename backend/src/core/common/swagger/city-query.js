import { SwaggerDocument } from '../../../packages/swagger';

export const CityQuery = SwaggerDocument.ApiParams({
    name: 'city',
    paramsIn: 'query',
    type: 'string',
    required: false,
    description: 'Municipal city/province name to look up campaigns in the area',
});
