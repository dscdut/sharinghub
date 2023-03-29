import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateDonationInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        itemName: JoiUtils.requiredString().min(1),
        quantity: JoiUtils.requiredString().min(1),
    })
);
