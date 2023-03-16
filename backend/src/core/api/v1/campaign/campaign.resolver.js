import { Module } from 'packages/handler/Module';

import { CoordinateCampaignInterceptor, CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';
import { orgCampaignId, campaignId, RecordId, NameQuery, LongitudeQuery, LatitudeQuery } from '../../../common/swagger';
import { RecordIdInterceptor } from '../../../modules/interceptor/recordId/record-id.interceptor';

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
        },
        {
            route: '/campaigns/:id',
            method: 'get',
            params: [RecordId],
            interceptors: [RecordIdInterceptor],
            controller: CampaignController.findOneById,
        },
        {
            route: '/campaigns',
            method: 'get',
            params: [NameQuery, LongitudeQuery, LatitudeQuery],
            interceptors: [CoordinateCampaignInterceptor],
            controller: CampaignController.searchByQuery,
        }
    ]);
