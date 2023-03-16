import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        image: Joi.string().trim().min(1).optional(),
        address: JoiUtils.requiredString().min(1),
        specific_address: Joi.string().trim().min(1).optional(),
        coordinate: Joi.object({
            lat: Joi.number().optional(),
            lng: Joi.number().optional(),
        }).optional(),
        start_date: Joi.date().required(),
        end_date: Joi.date().required(),
        description: JoiUtils.requiredString().min(1),
        register_link: Joi.string().trim().min(1).optional(),
        donation_requirement: Joi.string().trim().optional(),
    }),
);
