import { UserService } from '../../modules/user/services/user.service';
import { CreateUserDto, UpdateUserDto } from '../../modules/user/dto';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = UserService;
    }

    updateOne = async req => {
        await this.service.upsertOne(UpdateUserDto(req.body), req.user.payload.userId);
        return ValidHttpResponse.toNoContentResponse();
    };

    createOne = async req => {
        const data = await this.service.createOne(CreateUserDto(req.body));
        return ValidHttpResponse.toCreatedResponse(data[0]);
    };

    findById = async req => {
        const data = await this.service.findById(req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };
}

export const UserController = new Controller();
