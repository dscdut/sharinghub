import { UserService } from '../../../modules/user/services/user.service';
import { UpdateUserDto } from '../../../modules/user/dto';
import { ValidHttpResponse } from '../../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = UserService;
    }

    updateOne = async req => {
        const data = await this.service.upsertOne(UpdateUserDto(req.body), req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    findById = async req => {
        const data = await this.service.findById(req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    findVoluntaryCampaignsByUserId = async req => {
        const data = await this.service.findVoluntaryCampaignsByUserId(req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    }

    findAllUserNoOrg = async req => {
        const data = await this.service.findAllUserNoOrg();
        return ValidHttpResponse.toOkResponse(data);
    }
}

export const UserController = new Controller();