import { SwaggerDocument } from '../../../packages/swagger';

export const orgCampaignId = SwaggerDocument.ApiParams({
    name: 'organizationId',
    paramsIn: 'path',
    type: 'int',
    required: true,
    description: 'Organization Id to find',
});
