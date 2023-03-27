import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const UpdateUserInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        email: JoiUtils.email().required(),
        fullName: JoiUtils.requiredString().min(1),
        gender: Joi.boolean(),
        birthday: JoiUtils.date(),
        phoneNumber: JoiUtils.phoneNumber(),
        address: Joi.string().trim(),
        avatar: Joi.string().trim(),
        workplace: Joi.string().trim(),
    })
);
