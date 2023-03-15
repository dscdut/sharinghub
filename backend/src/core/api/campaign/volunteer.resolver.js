import { Module } from 'packages/handler/Module';
import { CampaignController } from './campaign.controller';
import { orgCampaignId, campaignId, RecordId, volunteerId } from '../../common/swagger';
import { RecordIdInterceptor } from '../../modules/interceptor/recordId/record-id.interceptor';
import { UpdateUserStatusInterceptor } from '../../modules/user_campaign/interceptor';

export const VolunteerResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1',
        tag: 'volunteers',
        module: 'VolunteerModule',
    })
    .register([
        {
            route: '/campaigns/:id/volunteers',
            method: 'post',
            params: [RecordId],
            interceptors: [RecordIdInterceptor],
            controller: CampaignController.registerVolunteer,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/volunteers',
            method: 'get',
            description: 'Get all approved volunteers',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.getAllVolunteersByOrgIdAndCampaignId,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/pending-volunteers',
            method: 'get',
            params: [orgCampaignId, campaignId],
            controller: CampaignController.getAllPendingVolunteersByOrgIdAndCampaignId,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/volunteers/:volunteerId',
            description: 'Update status of a volunteer',
            method: 'patch',
            params: [orgCampaignId, campaignId, volunteerId],
            interceptors: [UpdateUserStatusInterceptor],
            body: 'UpdateUserStatusDto',
            controller: CampaignController.updateVolunteerStatus,
            preAuthorization: true,
        },
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/volunteers',
            description: 'Set status of pending volunteers to rejected',
            method: 'patch',
            controller: CampaignController.setPendingVolunteersStatusToRejected,
            preAuthorization: true,
        },
    ]);
