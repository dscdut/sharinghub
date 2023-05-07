import { Module } from 'packages/handler/Module';
import { CampaignController } from './campaign.controller';
import { donationId, campaignId, orgCampaignId} from '../../../common/swagger';
import { uploadMediaSwagger } from 'core/common/swagger';
import { MediaInterceptor } from 'core/modules/document';
import { CreateDonationInterceptor, UpdateDonorStatusInterceptor } from 'core/modules/donation/interceptor';

export const DonationResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1',
        tag: 'donations',
        module: 'DonationModule',
    })
    .register([
        {
            route: '/campaigns/:campaignId/donations',
            method: 'post',
            interceptors: [new MediaInterceptor(10), CreateDonationInterceptor],
            body: 'CreateDonationDto',
            consumes: ['multipart/form-data'],
            params: [campaignId, uploadMediaSwagger],
            controller: CampaignController.createOrUpdateDonation,
            preAuthorization: true,         
        },
        {
            route: '/campaigns/:campaignId/donations',
            method: 'get',
            params: [campaignId],
            controller: CampaignController.getDonations,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/donations/:donationId',
            method: 'get',
            params: [campaignId, donationId],
            controller: CampaignController.getDonation,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId/donations/:donationId',
            method: 'put',
            interceptors: [new MediaInterceptor(10), CreateDonationInterceptor],
            body: 'CreateDonationDto',
            consumes: ['multipart/form-data'],
            params: [campaignId, donationId, uploadMediaSwagger],
            controller: CampaignController.createOrUpdateDonation,
            preAuthorization: true,         
        },
        {
            route: '/campaigns/:campaignId/donations/:donationId',
            method: 'delete',
            params: [campaignId, donationId],
            controller: CampaignController.deleteDonation,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/pending-donors',
            description: 'get all pending donors',
            method: 'get',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.getPendingDonors,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/donors/:donationId',
            description: 'Update status of a donor',
            method: 'patch',
            params: [orgCampaignId, campaignId, donationId],
            interceptors: [UpdateDonorStatusInterceptor],
            body: 'UpdateDonorsStatusDto',
            controller: CampaignController.updateDonorsStatus,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/donors',
            description: 'Set status of pending donors to rejected',
            method: 'patch',
            controller: CampaignController.setPendingDonorsStatusToRejected,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/donors',
            description: 'Get all approved donors',
            method: 'get',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.getDonors,
            preAuthorization: true,
        },
    ]);
