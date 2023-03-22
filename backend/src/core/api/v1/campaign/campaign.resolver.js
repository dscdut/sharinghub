import { Module } from 'packages/handler/Module';
import { CoordinateCampaignInterceptor, CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';
import { orgCampaignId, campaignId, RecordId, NameQuery, LongitudeQuery, LatitudeQuery } from '../../../common/swagger';
import { RecordIdInterceptor } from '../../../modules/interceptor/recordId/record-id.interceptor';
import { MediaInterceptor } from 'core/modules/document';
import { uploadMediaSwagger } from 'core/common/swagger';

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
            route: '/organizations/:organizationId/campaigns',
            method: 'post',
            interceptors: [new MediaInterceptor(), CreateCampaignInterceptor],
            body: 'CreateCampaignDto',
            consumes: ['multipart/form-data'],
            params: [orgCampaignId, uploadMediaSwagger],
            controller: CampaignController.createOne,
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
            route: '/campaigns/coordinates',
            method: 'get',
            controller: CampaignController.getAllCoordinates,
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
