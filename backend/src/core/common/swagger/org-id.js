import { SwaggerDocument } from '../../../packages/swagger';

export const orgId = SwaggerDocument.ApiParams({
    name: 'id',
    paramsIn: 'path',
    type: 'integer',
    description: 'Organization Id to find',
});
