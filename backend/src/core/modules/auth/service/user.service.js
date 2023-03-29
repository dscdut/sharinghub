import { UserRoleRepository } from 'core/modules/role/userRole.repository';
import { BcryptService } from './bcrypt.service';
import { UserRepository } from '../../user/user.repository';
import { logger } from '../../../../packages/logger';
import { Optional } from '../../../utils';
import { DuplicateException, BadRequestException, InternalServerException } from '../../../../packages/httpException';

class Service {
    constructor() {
        this.repository = UserRepository;
        this.userRoleRepository = UserRoleRepository;
        this.bcryptService = BcryptService;
    }

    async findByEmail(email) {
        try {
            const data = await this.repository.findByEmail(email);

            return data[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findByPhoneNumber(phoneNumber) {
        try {
            const data = await this.repository.findByPhoneNumber(phoneNumber);

            return data[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async createUser(registerDto) {
        Optional.of(await this.findByEmail(registerDto.email)).throwIfPresent(new DuplicateException('This email is already existed'));

        if (registerDto.password !== registerDto.confirm_password) {
            throw new BadRequestException('Password does not match');
        }

        registerDto.password = this.bcryptService.hash(registerDto.password);

        try {
            delete registerDto.confirm_password;
            await this.repository.createUser(registerDto);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findByResetToken(token) {
        try {
            const data = await this.repository.findByResetToken(token);

            return data[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const UserService = new Service();
