import { OrgRepositoryService } from './org-repository.service';
import { JwtService } from '../../auth/service/jwt.service';
import { MESSAGE } from './message.enum';
import { ForbiddenException } from '../../../../packages/httpException';
import { FileSystemService } from '../../document/service/file-system.service';
import { OrgRepository } from '../org.repository';

class Service {
    constructor() {
        this.OrgRepositoryService = OrgRepositoryService;
        this.JwtService = JwtService;
        this.FileSystemService = FileSystemService;
        this.repository = OrgRepository;
    }

    async updateOrgTable(file, orgDto, user, orgId) {
        if (orgId && !user.organization_ids.includes(Number(orgId))) {
            this.OrgRepositoryService.deleteFile(file);
            throw new ForbiddenException('You don\'t have permission to edit this organization');
        }

        if (!orgId && user.organization_ids.length > 0) {
            this.OrgRepositoryService.deleteFile(file);
            throw new ForbiddenException('You can only create one organization');
        }

        const [{ id }] = await this.OrgRepositoryService.updateOrgTable(file, { ...orgDto, user_id: user.id, id: orgId });

        if (!user.organization_ids.includes(id)) {
            user.organization_ids.push(id);

            user = { id: user.id, organization_ids: user.organization_ids };

            return {
                message: MESSAGE.CREATE_ORG_SUCCESS,
                accessToken: this.JwtService.sign(user),
            };
        }
        return {
            message: MESSAGE.UPDATE_ORG_SUCCESS,
        };
    }

    async getAllOrgs() {
        return {
            data: {
                organizations: await this.repository.findAllOrgs()
            }
        }
    }

    async getMyOrgs(user) {
        return this.OrgRepositoryService.findUsersOrgsById(user.id);
    }

    async getOrgById(user, orgId) {
        const data = await this.OrgRepositoryService.findOrgById(orgId);
        let editable = false;
        if (user.organization_ids.includes(Number(orgId))) {
            editable = true;
        }
        return { ...data, editable };
    }

    async deleteOrg(user, orgId) {
        if (!user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException('You don\'t have permission to delete this organization or the organization doesn\'t exist');
        }
        await this.OrgRepositoryService.deleteOrgById(orgId);

        user = { id: user.id, organization_ids: user.organization_ids.filter(org => org != orgId) };

        return {
            message: MESSAGE.DELETE_ORG_SUCCESS,
            accessToken: this.JwtService.sign(user),
        };
    }
}

export const OrgService = new Service();
