import { SwaggerDocument } from '../../../packages/swagger';

export const userId = SwaggerDocument.ApiParams({
    name: 'userId',
    paramsIn: 'path',
    type: 'int',
    required: true,
    description: 'User Id to find',
});
