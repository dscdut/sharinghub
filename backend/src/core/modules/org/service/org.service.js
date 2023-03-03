import { OrgRepositoryService } from './org-repository.service';

class Service {
    constructor() {
        this.OrgRepositoryService = OrgRepositoryService;
    }

    async createOrg(orgDto, user) {
        await this.OrgRepositoryService.createOrg({ ...orgDto, user_id: user.id });
        return {
            message: 'Organization created successfully',
        };
    }

    async getMyOrgs(user) {
        return this.OrgRepositoryService.findUsersOrgsById(user.id);
    }

    async getOrgById(user, orgId) {
        const data = await this.OrgRepositoryService.findOrgById(orgId.id);

        let editable = false;

        if (data.user_id === user.id) {
            editable = true;
        }
        return { ...data, editable };
    }
}

export const OrgService = new Service();
