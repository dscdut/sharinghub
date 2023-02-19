import { pick } from 'lodash';
import { JwtPayload } from 'core/modules/auth/dto/jwt-sign.dto';
import { UserDataService } from 'core/modules/user/services/userData.service';
import { joinUserRoles } from 'core/utils/userFilter';
import { BcryptService } from './bcrypt.service';
import { JwtService } from './jwt.service';
import { UserRepository } from '../../user/user.repository';
import { UnAuthorizedException, DuplicateException } from '../../../../packages/httpException';

class Service {
    constructor() {
        this.userRepository = UserRepository;
        this.jwtService = JwtService;
        this.bcryptService = BcryptService;
        this.userDataService = UserDataService;
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
                const password = this.bcryptService.hash(registerDto.password, 12);
                await this.userRepository.createUser({
                    full_name: registerDto.full_name,
                    email: registerDto.email,
                    password,
                    role_id: registerDto.role_id
                });
                return {
                    message: 'created new user successfully',
                };
            }
            throw new DuplicateException('password and confirmation password does not match');
        }
        throw new DuplicateException('This email is already existed');
    }

    #getUserInfo = user => pick(user, ['_id', 'email', 'username', 'roles']);
}

export const AuthService = new Service();
