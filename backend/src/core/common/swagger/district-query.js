import { SwaggerDocument } from '../../../packages/swagger';

export const DistrictQuery = SwaggerDocument.ApiParams({
    name: 'district',
    paramsIn: 'query',
    type: 'string',
    required: false,
    description: 'District/provincial city name to look up campaigns in the area',
});
