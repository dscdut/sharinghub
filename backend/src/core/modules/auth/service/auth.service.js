import { pick } from 'lodash';
import { UserDataService } from 'core/modules/user/services/userData.service';
import { OrgRepositoryService } from 'core/modules/org/service/org-repository.service';
import { BcryptService } from './bcrypt.service';
import { JwtService } from './jwt.service';
import { NodemailerService } from './nodemailer.service';
import { CryptoService } from './crypto.service';
import { UserService } from './user.service';
import { UserRepository } from '../../user/user.repository';
import { UnAuthorizedException, BadRequestException } from '../../../../packages/httpException';
import { MESSAGE } from './message.enum';
import { MAIL } from './mail.enum';
import { logger } from '../../../../packages/logger';

class Service {
    constructor() {
        this.userRepository = UserRepository;
        this.jwtService = JwtService;
        this.bcryptService = BcryptService;
        this.userDataService = UserDataService;
        this.NodemailerService = NodemailerService;
        this.UserService = UserService;
        this.OrgRepositoryService = OrgRepositoryService;
    }

    async login(loginDto) {
        const user = await this.UserService.findByEmail(loginDto.email);

        if (user) {
            if (this.bcryptService.compare(loginDto.password, user.password)) {             
                const organizations =  await this.OrgRepositoryService.findUsersOrgsById(user.id);

                const organization_ids = organizations.map(org => org.id);

                const { id, fullName, email, phoneNumber, birthday, avatar, address } = user;

                return {
                    message: MESSAGE.LOGIN_SUCCESS,
                    user: { 
                        id, fullName, email, phoneNumber, birthday, avatar, address, organizations,
                    },
                    accessToken: this.jwtService.sign({ id: user.id, organization_ids }),
                };
            }
        }
        throw new UnAuthorizedException('Email or password is incorrect');
    }

    async register(registerDto) {
        await this.UserService.createUser(registerDto);

        NodemailerService.sendMail(registerDto.email, MAIL.REGISTER_SUCCESS);

        return {
            message: MESSAGE.REGISTER_SUCCESS
        };
    }

    async forgotPassword(forgotPasswordDto) {
        const user = await UserService.findByEmail(forgotPasswordDto.email);

        if (user) {
            try {
                const token = await CryptoService.getRandomBytes();

                await this.userRepository.setResetToken(forgotPasswordDto.email, token);
                NodemailerService.sendMail(forgotPasswordDto.email, MAIL.FORGOT_PASSWORD(token));

                return {
                    message: MESSAGE.REQUEST_RESET_PASSWORD_SUCCESS,
                };
            } catch (error) {
                logger.error(error.message);
            }
        }
        throw new UnAuthorizedException('Email is not existed');
    }

    async getResetPassword(params) {
        const user = await UserService.findByResetToken(params.token);

        if (user) {
            return {
                message: MESSAGE.VALID_TOKEN,
                token: params.token,
            };
        }
        throw new UnAuthorizedException('Invalid or expired token');
    }

    async updatePassword(updatePasswordDto) {
        const user = await UserService.findByResetToken(updatePasswordDto.reset_token);

        if (user) {
            if (updatePasswordDto.password.toString() === updatePasswordDto.confirm_password.toString()) {
                try {
                    const password = this.bcryptService.hash(updatePasswordDto.password);

                    await this.userRepository.updatePassword(user.email, password);
                    NodemailerService.sendMail(user.email, MAIL.PASSWORD_UPDATE);

                    return {
                        message: MESSAGE.RESET_PASSWORD_SUCCESS,
                    };
                } catch (error) {
                    logger.error(error.message);
                }
            }
            throw new BadRequestException('Password and confirmation password does not match');
        }
        throw new UnAuthorizedException('Invalid or expired token');
    }

    #getUserInfo = user => pick(user, ['_id', 'email', 'username', 'roles']);
}

export const AuthService = new Service();
