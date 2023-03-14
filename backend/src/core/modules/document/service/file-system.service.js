import { unlink, unlinkSync } from 'fs';
import { logger } from 'packages/logger';
import { InternalServerException } from 'packages/httpException';
import { exceptions } from 'winston';
class Service {
    constructor() {
        this.logger = logger;
    }
    deleteFile(file) {
        try {
            unlinkSync(file.path);
        } catch(err) {
            this.logger.error(err.message);
            throw new InternalServerException(err.message);
        }  
    }
}

export const FileSystemService = new Service();
