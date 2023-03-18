import { Module } from 'packages/handler/Module';
import { FeedbackInterceptor } from '../../../modules/feedback';
import { MediaInterceptor } from 'core/modules/document';
import { uploadMediaSwagger } from 'core/common/swagger';
import { FeedbackController } from './feedback.controller';
import { campaignId } from '../../../common/swagger';

export const FeedbackResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1',
        tag: 'feedbacks',
        module: 'FeedbackModule',
    
    })
    .register([
        {
            route: '/campaigns/:campaignId',
            method: 'post',
            interceptors: [new MediaInterceptor(10), FeedbackInterceptor],
            body: 'CreateFeedbackDto',
            params: [campaignId, uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: FeedbackController.createOrUpdateFeedback,
            preAuthorization: true,
        },
        {
            route: '/campaigns/:campaignId',
            method: 'put',
            interceptors: [new MediaInterceptor(10), FeedbackInterceptor],
            body: 'CreateFeedbackDto',
            params: [campaignId, uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: FeedbackController.createOrUpdateFeedback,
            preAuthorization: true,
        }
    ])