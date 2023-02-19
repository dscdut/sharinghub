import { AuthService } from '../../modules/auth/service/auth.service';
import { LoginDto, RegisterDto } from '../../modules/auth';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = AuthService;
    }

    login = async req => {
        const data = await this.service.login(LoginDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    }

    register = async req => {
        const data = await this.service.register(RegisterDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
        // return ValidHttpResponse.toNoContentResponse();
    }
}

export const AuthController = new Controller();
