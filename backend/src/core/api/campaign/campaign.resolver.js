import { Module } from 'packages/handler/Module';

import { CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';

export const CampaignResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1/organizations',
        tag: 'campaigns',
        module: 'CampaignModule',
    })
    .register([
        {
            route: '/:organization_id/campaigns',
            method: 'post',
            interceptors: [CreateCampaignInterceptor],
            body: 'CreateCampaignDto',
            controller: CampaignController.createOne,
            preAuthorization: true,
        },
    ]);
