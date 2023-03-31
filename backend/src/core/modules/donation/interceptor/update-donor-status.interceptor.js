import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const UpdateDonorStatusInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        status: JoiUtils.requiredNumber()
            .min(1)
            .max(3)
            .message('status must be 1, 2 or 3')
    }),
);