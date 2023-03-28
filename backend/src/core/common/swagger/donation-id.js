import { SwaggerDocument } from '../../../packages/swagger';

export const donationId = SwaggerDocument.ApiParams({
    name: 'donationId',
    paramsIn: 'path',
    type: 'int',
    required: true,
    description: 'Donation Id to find',
});
