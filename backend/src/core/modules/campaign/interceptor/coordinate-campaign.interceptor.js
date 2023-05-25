import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';

export const CoordinateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: Joi.string().trim().optional().empty(''),
        lng: Joi.number().optional(),
        lat: Joi.number().optional(),
    }),
);