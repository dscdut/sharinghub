import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const RecordIdInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        id: JoiUtils.positiveNumber().message(
            'Url params contain unexpected id format! It should be a positive number and greater than 0',
        ),
    }),
);
