import { logger } from '../../../../packages/logger';
import { OrgRepository } from '../org-repository';
import { InternalServerException, BadRequestException } from '../../../../packages/httpException';

class Service {
    constructor() {
        this.repository = OrgRepository;
    }

    async createOrg(createOrgDto) {
        try {
            await this.repository.createOrg(createOrgDto);
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
            // eslint-disable-next-line quotes
            if (!data.length) throw new BadRequestException("Organization doesn't exist");

            return data[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const OrgRepositoryService = new Service();
