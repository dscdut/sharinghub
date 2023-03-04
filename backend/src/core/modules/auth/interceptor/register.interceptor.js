import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const RegisterInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        email: JoiUtils.email().required(),
        fullName: JoiUtils.requiredString().min(1),
        password: JoiUtils.password().required(),
        confirmPassword: JoiUtils.password().required(),
        birthday: JoiUtils.date().required(),
        gender: JoiUtils.requiredBoolean(),
        phoneNumber: JoiUtils.requiredString().min(1),
        address: JoiUtils.requiredString().min(1)
    })
);
