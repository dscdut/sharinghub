import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const CreateUserFeedbackInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        organizationRate: JoiUtils.positiveNumber().required().less(6),
        organizationFeedback: JoiUtils.optionalString(),
        campaignRate: JoiUtils.positiveNumber().required().less(6),
        campaignFeedback: JoiUtils.optionalString(),
    })
);
