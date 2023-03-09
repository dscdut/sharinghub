import { Module } from 'packages/handler/Module';

import { CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';
import { orgCampaignId, campaignId } from '../../common/swagger';

export const CampaignResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1',
        tag: 'campaigns',
        module: 'CampaignModule',
    })
    .register([
        {
            route: '/organizations/:organizationId/campaigns',
            method: 'get',
            params: [orgCampaignId],
            controller: CampaignController.findAllByOrgId,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId',
            method: 'get',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.findOneByOrgIdAndCampaignId,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns',
            method: 'post',
            interceptors: [CreateCampaignInterceptor],
            body: 'CreateCampaignDto',
            params: [orgCampaignId],
            controller: CampaignController.createOne,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId',
            method: 'patch',
            body: 'CreateCampaignDto',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.updateOne,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId',
            method: 'delete',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.deleteOne,
            preAuthorization: true,
        }
    ]);
