import { OrgRepositoryService } from './org-repository.service';
import { JwtService } from '../../auth/service/jwt.service';
import { MESSAGE } from './message.enum';
import { ForbiddenException } from '../../../../packages/httpException';

class Service {
    constructor() {
        this.OrgRepositoryService = OrgRepositoryService;
        this.JwtService = JwtService;
    }

    async updateOrgTable(orgDto, user, orgId) {
        if (orgId && !user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException('You don\'t have permission to edit this organization');
        }
        const [{ id }] = await this.OrgRepositoryService.updateOrgTable({ ...orgDto, user_id: user.id, id: orgId });

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
}

export const OrgService = new Service();
