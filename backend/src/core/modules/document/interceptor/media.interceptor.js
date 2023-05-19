import { ROOT_DIR } from 'core/env';
import { BaseMulterInterceptor } from './multer.interceptor';
import { MulterUploader } from '../multer.handler';

export class MediaInterceptor extends BaseMulterInterceptor {
    constructor(fileQuantity = 1) {
        super(new MulterUploader(
            ['.png', '.jpg', '.jpeg', 'webp'],
            'image',
            fileQuantity,
            `${ROOT_DIR}/core/uploads/media`
        ));
    }
}
