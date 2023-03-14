import { Optional } from 'core/utils';
import { logger } from '../../../../packages/logger';
import { OrgRepository } from '../org.repository';
import {
    InternalServerException,
    BadRequestException,
    DuplicateException,
} from '../../../../packages/httpException';
import { MediaService } from 'core/modules/document';
import { FileSystemService } from 'core/modules/document';

class Service {
    constructor() {
        this.repository = OrgRepository;
        this.MediaService = MediaService;
        this.FileSystemService = FileSystemService;
    }
    
    deleteFile(file) {
        try {
            if (file) {
                this.FileSystemService.deleteFile(file);
            }
        } catch(error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
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

    async updateOrgTable(file, orgDto) {
        try {
            Optional.of(await this.findOrgByExactName(orgDto.id, orgDto.name)).throwIfPresent(new DuplicateException('This name is already existed'));
            Optional.of(await this.findOrgByPhoneNumber(orgDto.id, orgDto.phone_number)).throwIfPresent(new DuplicateException('This phone number is already existed'));
        } catch(error) {
            if (file) {
                this.deleteFile(file);
            }
            throw error;
        }
        
        if (!orgDto.id) {
            return this.createOrg(file, orgDto);
        }
        return this.updateOrg(file, orgDto);
    }

    async createOrg(file, orgDto) {
        try {
            const [{ id }] = await this.repository.createOrg(orgDto);

            return this.updateOrg(file, { ...orgDto, id });
        } catch (error) {
            this.deleteFile(file);
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateOrg(file, orgDto) {
        try {
            const url = file ? (await this.MediaService.uploadOne(file, `organizations/${orgDto.id}/avatar`, 'avatar', true)).url : null;
            return this.repository.updateOrg({...orgDto, avatar: url});
        } catch (error) {
            this.deleteFile(file);
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
