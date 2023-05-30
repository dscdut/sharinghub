import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateUserFeedbackDto', {
    organizationRate: SwaggerDocument.ApiProperty({ type: 'int' }),
    organizationFeedback: SwaggerDocument.ApiProperty({ type: 'string' }),
    campaignRate: SwaggerDocument.ApiProperty({ type: 'int' }),
    campaignFeedback: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const CreateUserFeedbackDto = body => ({
    organization_rate: body.organizationRate,
    organization_feedback: body.organizationFeedback,
    campaign_rate: body.campaignRate,
    campaign_feedback: body.campaignFeedback,
});
