import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const CreateRoleInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: JoiUtils.requiredString().min(1),
        color: JoiUtils.color().required(),
        serverId: JoiUtils.objectId().required(),
        permissions: JoiUtils.ObjectIds(),
    })
);
