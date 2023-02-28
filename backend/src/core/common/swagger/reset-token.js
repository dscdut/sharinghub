import { SwaggerDocument } from '../../../packages/swagger';

export const resetToken = SwaggerDocument.ApiParams({
    name: 'token',
    paramsIn: 'path',
    type: 'string',
    description: 'token to reset password',
});
