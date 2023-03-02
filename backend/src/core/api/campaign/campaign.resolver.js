import { Module } from 'packages/handler/Module';

import { CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';

export const CampaignResolver = Module.builder()
    .addPrefix({
        prefixPath: '/campaigns',
        tag: 'campaigns',
        module: 'CampaignModule',
    })
    .register([
        {
            route: '/create',
            method: 'post',
            interceptors: [CreateCampaignInterceptor],
            body: 'CreateCampaignDto',
            controller: CampaignController.createOne,
            preAuthorization: true,
        },
    ]);
