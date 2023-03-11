import { AuthService } from '../../modules/auth/service/auth.service';
import {
    LoginDto,
    RegisterDto,
    ForgotPasswordDto,
    UpdatePasswordDto
} from '../../modules/auth';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = AuthService;
    }

    login = async req => {
        const data = await this.service.login(LoginDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };

    register = async req => {
        const data = await this.service.register(RegisterDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };

    forgotPassword = async req => {
        const data = await this.service.forgotPassword(ForgotPasswordDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };

    getResetPassword = async req => {
        const data = await this.service.getResetPassword(req.params);
        return ValidHttpResponse.toOkResponse(data);
    };

    updatePassword = async req => {
        const data = await this.service.updatePassword(UpdatePasswordDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };
}

export const AuthController = new Controller();
