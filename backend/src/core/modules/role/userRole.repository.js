import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    createUserRole(user_id, role_id = 3, trx = null) {
        const queryBuilder = this.query().insert({
            user_id,
            role_id,
        });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }
}

export const UserRoleRepository = new Repository('users_roles');
