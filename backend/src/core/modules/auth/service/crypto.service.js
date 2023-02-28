import crypto from 'crypto';
import { logger } from '../../../../packages/logger';

class Crypto {
    constructor() {
        logger.info(`[${Crypto.name}] is bundling`);
    }

    async getRandomBytes() {
        const randomBytes = crypto.randomBytes(32);
        return randomBytes.toString('hex');
    }
}

export const CryptoService = new Crypto();
