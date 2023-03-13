import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';

export const CoordinateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: Joi.string().trim().min(1).optional(),
        lng: Joi.number().optional(),
        lat: Joi.number().optional(),
    }),
);