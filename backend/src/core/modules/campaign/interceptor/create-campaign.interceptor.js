import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        address: JoiUtils.requiredString().min(1),
        specificAddress: Joi.string().trim().min(1).optional(),
        coordinate: Joi.object({
            lat: Joi.number().optional(),
            lng: Joi.number().optional(),
        }).optional(),
        startDate: Joi.date().required(),
        endDate: Joi.date().required(),
        description: JoiUtils.requiredString().min(1),
        registerLink: Joi.string().trim().min(1).optional(),
        donationRequirement: Joi.string().trim().optional(),
    }),
);
