import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const FeedbackInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        locationRate: JoiUtils.positiveNumber().required().less(6),
        traffic: JoiUtils.optionalString(),
        weather: JoiUtils.optionalString(),
        sanitization: JoiUtils.optionalString(),
        residence: JoiUtils.optionalString(),
        authorityCooperation: JoiUtils.optionalString(),
        others: JoiUtils.optionalString(),
    })
);