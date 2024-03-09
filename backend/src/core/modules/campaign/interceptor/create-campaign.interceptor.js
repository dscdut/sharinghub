import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        location: Joi.object({
            ward: Joi.string().required().min(1),
            district: Joi.string().required().min(1),
            city: Joi.string().required().min(1),
        }).required(),
        specificAddress: Joi.string().trim().min(1).optional(),
        coordinate: Joi.object({
            lat: Joi.number().required(),
            lng: Joi.number().required(),
        }).required(),
        startDate: Joi.date().required(),
        endDate: Joi.date().required(),
        description: JoiUtils.requiredString().min(1),
        registerLink: Joi.string().trim().min(1).optional(),
        donationRequirement: Joi.string().trim().optional(),
    }),
);
