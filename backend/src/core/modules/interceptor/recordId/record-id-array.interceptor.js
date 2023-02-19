import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';

export const RecordIdArrayInterceptor = DefaultValidatorInterceptor(
    Joi.object({
        ids: Joi.array()
            .items(
                JoiUtils.positiveNumber().message(
                    'Array contain unexpected id format! It should be a positive number and greater than 0',
                ),
            )
            .min(1)
            .required(),
    }),
);
