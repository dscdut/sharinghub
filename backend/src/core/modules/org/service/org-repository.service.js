import { Optional } from 'core/utils';
import { logger } from '../../../../packages/logger';
import { OrgRepository } from '../org.repository';
import {
    InternalServerException,
    BadRequestException,
    DuplicateException,
} from '../../../../packages/httpException';

class Service {
    constructor() {
        this.repository = OrgRepository;
    }

    async findOrgByExactName(id, name) {
        try {
            return this.repository.findOrgByExactName(id, name);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findOrgByPhoneNumber(id, phoneNumber) {
        try {
            return this.repository.findOrgByPhoneNumber(id, phoneNumber);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateOrgTable(orgDto) {
        Optional.of(await this.findOrgByExactName(orgDto.id, orgDto.name)).throwIfPresent(new DuplicateException('This name is already existed'));
        Optional.of(await this.findOrgByPhoneNumber(orgDto.id, orgDto.phone_number)).throwIfPresent(new DuplicateException('This phone number is already existed'));

        if (!orgDto.id) {
            return this.createOrg(orgDto);
        }
        return this.updateOrg(orgDto);
    }

    async createOrg(orgDto) {
        try {
            return this.repository.createOrg(orgDto);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateOrg(orgDto) {
        try {
            return this.repository.updateOrg(orgDto);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findUsersOrgsById(id) {
        try {
            return this.repository.findUsersOrgsById(id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findOrgById(id) {
        try {
            const data = await this.repository.findOrgById(id);

            if (!data.length) throw new BadRequestException('Organization doesn\'t exist');

            return data[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
    async deleteOrgById(id) {
        try {
            return this.repository.deleteOrgById(id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const OrgRepositoryService = new Service();
