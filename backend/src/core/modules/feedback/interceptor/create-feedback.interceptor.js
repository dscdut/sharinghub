import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const FeedbackInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        completedRate: JoiUtils.positiveNumber().required(),
        locationRate: JoiUtils.positiveNumber().required(),
        traffic: JoiUtils.optionalString(),
        weather: JoiUtils.optionalString(),
        sanitization: JoiUtils.optionalString(),
        residence: JoiUtils.optionalString(),
        authorityCooperation: JoiUtils.optionalString(),
        others: JoiUtils.optionalString(),
    })
);