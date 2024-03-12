import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';

export const SearchCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: Joi.string().trim().optional().empty(''),
        lng: Joi.number().optional(),
        lat: Joi.number().optional(),
        ward: Joi.string().optional(),
        district: Joi.string().optional(),
        city: Joi.string().optional(),
        isSortedByStatus: Joi.boolean().optional(),
    }),
);