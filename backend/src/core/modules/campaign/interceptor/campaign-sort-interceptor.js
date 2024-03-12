import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';

export const CampaignSortInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
    }),
);
