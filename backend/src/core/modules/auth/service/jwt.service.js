import { sign, decode, verify } from 'jsonwebtoken';
import { JWT_SECRET, EXPIRE_DAYS } from '../../../env';
import { logger } from '../../../../packages/logger';

class Jwt {
    secret = JWT_SECRET;

    expiresIn = EXPIRE_DAYS;

    constructor() {
        logger.info(`[${Jwt.name}] is bundling`);
    }

    sign(payload) {
        return sign(payload, this.secret, {
            expiresIn: this.expiresIn
        });
    }

    decode(token) {
        return decode(token);
    }

    verify(token) {
        return verify(token, this.secret);
    }
}

export const JwtService = new Jwt();
