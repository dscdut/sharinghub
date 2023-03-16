import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const UpdateUserInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        email: JoiUtils.email().required(),
        full_name: JoiUtils.requiredString().min(1),
        gender: Joi.boolean(),
        birthday: JoiUtils.date(),
        phone_number: JoiUtils.phoneNumber(),
        address: Joi.string().trim(),
        avatar: Joi.string().trim(),
        workplace: Joi.string().trim(),
    })
);
