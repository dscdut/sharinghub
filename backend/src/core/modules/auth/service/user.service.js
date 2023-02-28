import { BcryptService } from 'core/modules/auth';
import { UserRoleRepository } from 'core/modules/role/userRole.repository';
import { joinUserRoles } from 'core/utils/userFilter';
import { InternalServerException } from '../../../../packages/httpException';
import { UserRepository } from '../../user/user.repository';
import { logger } from '../../../../packages/logger';

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
