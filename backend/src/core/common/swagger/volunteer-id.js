import { SwaggerDocument } from '../../../packages/swagger';

export const volunteerId = SwaggerDocument.ApiParams({
    name: 'volunteerId',
    paramsIn: 'path',
    type: 'int',
    description: 'Volunteer Id to find',
});