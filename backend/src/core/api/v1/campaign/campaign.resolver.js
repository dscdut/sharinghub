import { Module } from 'packages/handler/Module';
import { CoordinateCampaignInterceptor, CreateCampaignInterceptor } from 'core/modules/campaign/interceptor';
import { CampaignController } from './campaign.controller';
import { orgCampaignId, campaignId, RecordId, NameQuery, LongitudeQuery, LatitudeQuery, userId } from '../../../common/swagger';
import { RecordIdInterceptor } from '../../../modules/interceptor/recordId/record-id.interceptor';
import { FeedbackInterceptor } from '../../../modules/feedback';
import { MediaInterceptor } from 'core/modules/document';
import { uploadMediaSwagger } from 'core/common/swagger';
import { CreateUserFeedbackInterceptor } from 'core/modules/user_feedback';

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
        },
        {
            route: '/campaigns/:campaignId/feedbacks',
            method: 'post',
            interceptors: [new MediaInterceptor(10), FeedbackInterceptor],
            body: 'CreateFeedbackDto',
            params: [campaignId, uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: CampaignController.createOrUpdateFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/feedbacks',
            method: 'put',
            interceptors: [new MediaInterceptor(10), FeedbackInterceptor],
            body: 'CreateFeedbackDto',
            params: [campaignId, uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: CampaignController.createOrUpdateFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/feedbacks',
            method: 'delete',
            controller: CampaignController.deleteFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/user-feedbacks/:userId',
            method: 'get',
            params: [campaignId, userId],
            controller: CampaignController.getUserFeedback,
            preAuthorization: false,
        },
        {
            route: '/campaigns/:campaignId/user-feedbacks',
            method: 'post',
            interceptors: [CreateUserFeedbackInterceptor],
            body: 'CreateUserFeedbackDto',
            params: [campaignId],
            controller: CampaignController.createOrUpdateUserFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/user-feedbacks',
            method: 'put',
            interceptors: [CreateUserFeedbackInterceptor],
            body: 'CreateUserFeedbackDto',
            params: [campaignId],
            controller: CampaignController.createOrUpdateUserFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/user-feedbacks',
            method: 'delete',
            params: [campaignId],
            controller: CampaignController.deleteUserFeedback,
            preAuthorization: true,
        },
        {
            route: '/dev/organizations/:organizationId/campaigns/:campaignId',
            description: 'delete campaign without authorization',
            method: 'delete',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.deleteOneWithoutAuth,
        },
        {
            route: '/dev/remove-campaign-name-constraint',
            description: 'remove campaign name constraint',
            method: 'post',
            controller: CampaignController.removeNameConstraint,
        },
    ]);
