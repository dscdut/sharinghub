import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findByEmail(email) {
        return this.query()
            .innerJoin('users_roles', 'users_roles.user_id', 'users.id')
            .innerJoin('roles', 'roles.id', 'users_roles.role_id')
            .whereNull('users.deleted_at')
            .where('users.email', '=', email)
            .select(
                'users.id',
                'users.email',
                'users.password',
                { role: 'roles.name' },
                { fullName: 'users.full_name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }

    findById(id) {
        return this.query()
            .innerJoin('users_roles', 'users_roles.user_id', 'users.id')
            .innerJoin('roles', 'roles.id', 'users_roles.role_id')
            .whereNull('users.deleted_at')
            .where('users.id', '=', id)
            .select(
                'users.id',
                'users.email',
                { fullName: 'users.full_name' },
                { role: 'roles.name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }

    findRoles(id) {
        return this.query().innerJoin('users_roles', 'users_roles.user_id', 'users.id').where('users.id', '=', id).select('roles.name');
    }

    async createUser(user) {
        const [{ id }] = await this.query()
            .insert({ full_name: user.full_name, email: user.email, password: user.password })
            .into('users')
            .returning('id');
        return this.query().insert({ user_id: id, role_id: user.role_id }).into('users_roles');
    }

    setResetToken(email, token) {
        const now = new Date();
        return this.query().where('email', '=', email).update({ reset_token: token, reset_token_expiration_date: new Date(now.getTime() + 60 * 60 * 1000) }).into('users');
    }

    findByResetToken(token) {
        const now = new Date().toISOString();
        return this.query()
            .innerJoin('users_roles', 'users_roles.user_id', 'users.id')
            .innerJoin('roles', 'roles.id', 'users_roles.role_id')
            .whereNull('users.deleted_at')
            .where('reset_token', '=', token)
            .where('reset_token_expiration_date', '>', now)
            .select(
                'users.id',
                'users.email',
                { fullName: 'users.full_name' },
                { role: 'roles.name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }

    updatePassword(email, password) {
        return this.query().where('email', '=', email).update({
            password,
            reset_token: null,
            reset_token_expiration_date: null,
        }).into('users');
    }
}

export const UserRepository = new Repository('users');
