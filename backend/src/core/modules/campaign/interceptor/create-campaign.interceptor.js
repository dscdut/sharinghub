import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        province: JoiUtils.requiredString().min(1),
        district: JoiUtils.requiredString().min(1),
        ward: JoiUtils.requiredString().min(1),
        address: JoiUtils.requiredString().min(1),
        longitude: Joi.number().optional(),
        latitude: Joi.number().optional(),
        start_date: Joi.date().required(),
        end_date: Joi.date().required(),
        description: JoiUtils.requiredString().min(1),
        register_link: JoiUtils.requiredString().min(1),
        donation_method: Joi.number().optional(),
        organization_id: JoiUtils.requiredNumber(),
    }),
);
