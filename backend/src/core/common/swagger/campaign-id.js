import { SwaggerDocument } from '../../../packages/swagger';

export const campaignId = SwaggerDocument.ApiParams({
    name: 'campaignId',
    paramsIn: 'path',
    type: 'int',
    required: true,
    description: 'Campaign Id to find',
});
