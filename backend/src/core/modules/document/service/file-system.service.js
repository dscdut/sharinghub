import { unlink } from 'fs';
import { logger } from 'packages/logger';
import { InternalServerException } from 'packages/httpException';
import { promisify } from 'util';

class Service {
    constructor() {
        this.logger = logger;
        this.unlinkPromisified = promisify(unlink);
    }

    async deleteFile(file) {
        try {
            await this.unlinkPromisified(file.path);
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException(error.message);
        }
    }
}

export const FileSystemService = new Service();
