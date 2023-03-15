import { SwaggerDocument } from '../../../packages/swagger';

export const campaignId = SwaggerDocument.ApiParams({
    name: 'campaignId',
    paramsIn: 'path',
    type: 'int',
    description: 'Campaign Id to find',
});
