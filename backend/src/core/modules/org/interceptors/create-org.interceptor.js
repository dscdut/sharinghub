import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateOrgInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        address: JoiUtils.requiredString().min(1),
        phoneNumber: JoiUtils.phoneNumber().required(),
        description: JoiUtils.requiredString().min(1),
    })
);
