import { SwaggerDocument } from '../../../packages/swagger';

export const CampaignSortQuery = SwaggerDocument.ApiParams({
    name: 'isSortedByStatus',
    paramsIn: 'query',
    type: 'bool',
    required: false,
    description: 'Sort campaigns by status as follows: UPCOMING, ENDED, IN PROGRESS',
});
