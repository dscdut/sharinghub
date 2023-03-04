import { Module } from 'packages/handler/Module';

import { CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';

export const CampaignResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1/campaigns',
        tag: 'campaigns',
        module: 'CampaignModule',
    })
    .register([
        {
            route: '/',
            method: 'post',
            interceptors: [CreateCampaignInterceptor],
            body: 'CreateCampaignDto',
            controller: CampaignController.createOne,
            preAuthorization: true,
        },
    ]);
