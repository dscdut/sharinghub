import { BcryptService } from 'core/modules/auth';
import { getTransaction } from 'core/database';
import { UserRoleRepository } from 'core/modules/role/userRole.repository';
import { joinUserRoles } from 'core/utils/userFilter';
import { Optional } from '../../../utils';
import { NotFoundException, DuplicateException, BadRequestException } from '../../../../packages/httpException';
import { UserRepository } from '../user.repository';

class Service {
    constructor() {
        this.repository = UserRepository;
        this.userRoleRepository = UserRoleRepository;
        this.bcryptService = BcryptService;
    }

    async createOne(createUserDto) {
        const trx = await getTransaction();
        Optional.of(await this.repository.findByEmail(createUserDto.email)).throwIfPresent(new DuplicateException('Email is being used'));

        if (createUserDto.password !== createUserDto.confirm_password) {
            throw new BadRequestException('Password does not match');
        }
        createUserDto.password = this.bcryptService.hash(createUserDto.password);

        let createdUser;
        try {
            delete createUserDto.confirm_password;
            createdUser = await this.repository.insert(createUserDto, trx);
            const ROLE_USER_ID = 3;
            await this.userRoleRepository.createUserRole(createdUser[0].id, ROLE_USER_ID, trx);
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            return null;
        }
        trx.commit();
        return createdUser[0];
    }

    async findById(id) {
        const data = Optional.of(await this.repository.findById(id))
            .throwIfNotPresent(new NotFoundException())
            .get();

        return joinUserRoles(data);
    }
}

export const UserService = new Service();
