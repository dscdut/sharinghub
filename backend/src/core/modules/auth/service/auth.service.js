import { pick } from 'lodash';
import { JwtPayload } from 'core/modules/auth/dto/jwt-sign.dto';
import { UserDataService } from 'core/modules/user/services/userData.service';
import { joinUserRoles } from 'core/utils/userFilter';
import { BcryptService } from './bcrypt.service';
import { JwtService } from './jwt.service';
import { NodemailerService } from './nodemailer.service';
import { CryptoService } from './crypto.service';
import { UserRepository } from '../../user/user.repository';
import { UnAuthorizedException, DuplicateException } from '../../../../packages/httpException';
import { MESSAGE } from './message.enum';
import { MAIL } from './mail.enum';

class Service {
    constructor() {
        this.userRepository = UserRepository;
        this.jwtService = JwtService;
        this.bcryptService = BcryptService;
        this.userDataService = UserDataService;
        this.NodemailerService = NodemailerService;
    }

    async login(loginDto) {
        const user = await this.userRepository.findByEmail(loginDto.email);
        if (user.length > 0) {
            const foundUser = joinUserRoles(user);
            if (this.bcryptService.compare(loginDto.password, user[0].password)) {
                return {
                    user: foundUser,
                    accessToken: this.jwtService.sign(JwtPayload(foundUser)),
                };
            }
        }
        throw new UnAuthorizedException('Email or password is incorrect');
    }

    async register(registerDto) {
        const [user] = await this.userRepository.findByEmail(registerDto.email);
        if (!user) {
            if (registerDto.password.toString() === registerDto.confirm_password.toString()) {
                try {
                    const password = this.bcryptService.hash(registerDto.password);
                    await this.userRepository.createUser({
                        full_name: registerDto.full_name,
                        email: registerDto.email,
                        password,
                        role_id: registerDto.role_id
                    });
                    NodemailerService.sendMail(registerDto.email, MAIL.REGISTER_SUCCESS);
                    return {
                        message: MESSAGE.REGISTER_SUCCESS,
                    };
                } catch (error) {
                    console.log(error);
                }
            }
            throw new DuplicateException('Password and confirmation password does not match');
        }
        throw new DuplicateException('This email is already existed');
    }

    async forgotPassword(forgotPasswordDto) {
        const user = await this.userRepository.findByEmail(forgotPasswordDto.email);
        if (user.length > 0) {
            try {
                const token = await CryptoService.getRandomBytes();
                await this.userRepository.setResetToken(forgotPasswordDto.email, token);
                NodemailerService.sendMail(forgotPasswordDto.email, MAIL.FORGOT_PASSWORD(token));
                return {
                    message: MESSAGE.REQUEST_RESET_PASSWORD_SUCCESS,
                };
            } catch (error) {
                console.log(error);
            }
        }
        throw new UnAuthorizedException('Email is not existed');
    }

    async getResetPassword(params) {
        const user = await this.userRepository.findByResetToken(params.token);
        if (user.length > 0) {
            return {
                message: MESSAGE.VALID_TOKEN,
                token: params.token,
            };
        }
        throw new UnAuthorizedException('Invalid or expired token');
    }

    async newPassword(newPasswordDto) {
        const user = await this.userRepository.findByResetToken(newPasswordDto.reset_token);
        if (user.length > 0) {
            if (newPasswordDto.password.toString() === newPasswordDto.confirm_password.toString()) {
                try {
                    const password = this.bcryptService.hash(newPasswordDto.password);
                    await this.userRepository.updatePassword(user[0].email, password);
                    NodemailerService.sendMail(user[0].email, MAIL.PASSWORD_UPDATE);
                    return {
                        message: MESSAGE.RESET_PASSWORD_SUCCESS,
                    };
                } catch (error) {
                    console.log(error);
                }
            }
            throw new DuplicateException('Password and confirmation password does not match');
        }
        throw new UnAuthorizedException('Invalid or expired token');
    }

    #getUserInfo = user => pick(user, ['_id', 'email', 'username', 'roles']);
}

export const AuthService = new Service();
