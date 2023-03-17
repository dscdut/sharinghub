import multer from 'multer';
import { MulterUploader } from 'core/modules/document/multer.handler';
import { logger } from 'packages/logger';
import { BadRequestException, InternalServerException } from '../../../../packages/httpException';

export class BaseMulterInterceptor {
    #uploader;

    #logger;

    constructor(uploader) {
        if (!(uploader instanceof MulterUploader)) {
            throw new Error(`Uploader must be instance of ${MulterUploader.name}`);
        }

        this.#uploader = uploader;
        this.#logger = logger;
    }

    intercept = (req, res, next) => {
        const uploadHandler = this.#uploader.getHandler();
        return uploadHandler(req, res, err => {
            if (err instanceof multer.MulterError) {
                this.#logger.error(err.code);
                return next(new BadRequestException(err.code));
            }
            if (err) {
                this.#logger.error(err.message);
                return next(new InternalServerException(err.message));
            }
            return next();
        });
    };
}
