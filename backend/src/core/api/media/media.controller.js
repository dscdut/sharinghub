import { DeleteFileDto, MediaService } from 'core/modules/document';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = MediaService;
    }

    uploadMany = async req => {
        const data = await this.service.uploadMany(req.files);
        return ValidHttpResponse.toOkResponse(data);
    };

    deleteMany = async req => {
        const data = await this.service.deleteMany(DeleteFileDto(req.body).ids);
        return ValidHttpResponse.toOkResponse(data);
    };
}

export const MediaController = new Controller();
