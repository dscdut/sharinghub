import { SwaggerDocument } from '../../../packages/swagger';

export const campaignId = SwaggerDocument.ApiParams({
    name: 'campaignId',
    paramsIn: 'path',
    type: 'integer',
    required: true,
    description: 'Campaign Id to find',
});
