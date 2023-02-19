import { BaseRepository } from '../../../infrastructure/repository/base.repository';

class Repository extends BaseRepository {
    createUserRole(id_user, id_role, trx = null) {
        const queryBuilder = this.query()
            .insert({
                id_user,
                id_role,
            });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }
}

export const RoleRepository = new Repository('roles');
