import { SwaggerDocument } from '../../../packages/swagger';

export const orgId = SwaggerDocument.ApiParams({
    name: 'id',
    paramsIn: 'path',
    type: 'int',
    description: 'Organization Id to find',
});
