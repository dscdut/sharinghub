import { UserRoleRepository } from 'core/modules/role/userRole.repository';
import { joinUserRoles } from 'core/utils/userFilter';
import { getTransaction } from 'core/database';
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

            return data.length ? joinUserRoles(data) : null;
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async createUser(registerDto) {
        const trx = await getTransaction();

        Optional.of(await this.repository.findByEmail(registerDto.email)).throwIfPresent(new DuplicateException('This email is already existed'));

        if (registerDto.password !== registerDto.confirm_password) {
            throw new BadRequestException('Password does not match');
        }
        if (Number(registerDto.role_id) !== 2 && Number(registerDto.role_id) !== 3) {
            throw new BadRequestException('Unknown or unauthorized role');
        }

        registerDto.password = this.bcryptService.hash(registerDto.password);

        let createdUser;
        try {
            const roleID = registerDto.role_id;

            delete registerDto.confirm_password;
            delete registerDto.role_id;

            createdUser = await this.repository.insert(registerDto, trx);
            await this.userRoleRepository.createUserRole(createdUser[0].id, roleID, trx);
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            return null;
        }
        trx.commit();
    }

    async findByResetToken(token) {
        try {
            const data = await this.repository.findByResetToken(token);

            return data.length ? joinUserRoles(data) : null;
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const UserService = new Service();
