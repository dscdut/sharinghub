import { Module } from 'packages/handler/Module';
import { FeedbackInterceptor } from '../../modules/feedback';
import { MediaInterceptor } from 'core/modules/document';
import { uploadMediaSwagger } from 'core/common/swagger';
import { FeedbackController } from './feedback.controller';
import { campaignId } from '../../common/swagger';
import { orgCampaignId } from '../../common/swagger';

export const FeedbackResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1',
        tag: 'feedbacks',
        module: 'FeedbackModule',
    
    })
    .register([
        {
            route: '/organizations/:organizationId/campaigns/:campaignId/feedbacks',
            method: 'get',
            params: [orgCampaignId, campaignId],
            controller: FeedbackController.getFeedback,
        }
    ])