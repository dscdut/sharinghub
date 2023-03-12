import { unlink } from 'fs';
import { logger } from 'packages/logger';
import { InternalServerException } from 'packages/httpException';
class Service {
    constructor() {
        this.logger = logger;
    }
    deleteFile(file) {
        if (file) {
            unlink(file.path, err => {
                if (err) {
                    this.logger.error(err.message);
                    throw new InternalServerException(err.message);
                }
            });
        }
    }
}

export const FileSystemService = new Service();
