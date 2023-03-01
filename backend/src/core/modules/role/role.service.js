import { RoleRepository } from 'core/modules/role/role.repository';
import { Optional } from 'core/utils';
import { NotFoundException } from 'packages/httpException';

class Service {
    constructor() {
        this.roleRepository = RoleRepository;
    }

    async findById(sectorId) {
        const sector = Optional.of(await this.roleRepository.findById(sectorId)).throwIfNotPresent(new NotFoundException());

        return sector.get();
    }
}

export const RoleService = new Service();
