import Joi from 'joi';

const MONGOOSE_ID_OBJECT_FORMAT = /^[0-9a-fA-F]{24}$/;

const DATE_YYYY_MM_DD_FORMAT = /^\d{4}-\d{2}-\d{2}$/;

// Required from 6-30 char, contains special char
const PWD_FORMAT = /^[a-zA-Z0-9\d@$!%*?&]{6,30}$/;

// Vietnam phone number validation
const PHONE_NUMBER_FORMAT = /(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b/;
export class JoiUtils {
    static objectId() {
        return Joi.string().regex(MONGOOSE_ID_OBJECT_FORMAT);
    }

    static requiredNumber() {
        return Joi
            .number()
            .required();
    }

    static optionalString() {
        return Joi
            .string()
            .optional();
    }

    static requiredString() {
        return Joi
            .string()
            .trim()
            .required();
    }

    static password() {
        return Joi.string().regex(PWD_FORMAT);
    }

    static email = () => Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } });

    static date(custom = false) {
        return custom
            ? Joi.string().regex(DATE_YYYY_MM_DD_FORMAT)
            : Joi.string().regex(DATE_YYYY_MM_DD_FORMAT)
                .message('Invalid date format. Should be YYYY-MM-DD');
    }

    static positiveNumber() {
        return Joi
            .number().positive().greater(0);
    }

    static optionalStrings() {
        return Joi.array().items(JoiUtils.optionalString()).min(1);
    }

    static ObjectIds() {
        return Joi.array().items(
            this.objectId()
        );
    }

    static requiredBoolean() {
        return Joi
            .boolean()
            .required();
    }

    static phoneNumber() {
        return Joi.string().regex(PHONE_NUMBER_FORMAT);
    }
}
