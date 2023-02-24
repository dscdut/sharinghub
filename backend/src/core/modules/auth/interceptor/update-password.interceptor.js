import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';
import Joi from 'joi';

export const NewPasswordInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        password: JoiUtils.password().required(),
        confirmPassword: JoiUtils.password().required(),
        resetToken: JoiUtils.requiredString(),
        // ID: JoiUtils.positiveNumber().required()
    })
);
