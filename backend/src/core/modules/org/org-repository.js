import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    createOrg(org) {
        return this.query().insert(org).into('organizations');
    }

    findUsersOrgsById(id) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .where('organizations.user_id', '=', id)
            .select('*');
    }

    findOrgByName(name) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .whereRaw('lower(username) like ?', `%${name.toLowerCase()}%`)
            .select('*');
    }

    findOrgById(id) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .where('organizations.id', '=', id)
            .select('*');
    }
}

export const OrgRepository = new Repository('organizations');
