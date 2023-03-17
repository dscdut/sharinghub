import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findByEmail(email) {
        return this.query()
            .whereNull('users.deleted_at')
            .where('users.email', '=', email)
            .select(
                'users.id',
                { fullName: 'users.full_name' },
                'users.email',
                'users.password',
                { phoneNumber: 'users.phone_number' },
                'users.birthday',
                'users.avatar',
                'users.address',
            );
    }

    findByPhoneNumber(phoneNumber) {
        return this.query()
            .whereNull('users.deleted_at')
            .where('users.phone_number', '=', phoneNumber)
            .select(
                'users.id',
                'users.email',
                'users.password',
                { phoneNumber: 'users.full_name' },
            );
    }

    createUser(user) {
        return this.query().insert(user).into('users');
    }

    updateUser(id, data = {}, trx = null) {
        const queryBuilder = this.query().whereNull('deleted_at').where({ id }).update(data).returning('*');

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    findById(id) {
        return this.query()
            .whereNull('users.deleted_at')
            .where('users.id', '=', id)
            .select(
                'users.avatar',
                { fullName: 'users.full_name' },
                { phoneNumber: 'users.phone_number' },
                'users.gender',
                'users.email',
                'users.birthday',
                'users.address',
                'users.workplace',
            );
    }

    setResetToken(email, token) {
        const now = new Date();
        return this.query().where('email', '=', email).update({ reset_token: token, reset_token_expiration_date: new Date(now.getTime() + 60 * 60 * 1000) }).into('users');
    }

    findByResetToken(token) {
        const now = new Date().toISOString();
        return this.query()
            .whereNull('users.deleted_at')
            .where('reset_token', '=', token)
            .where('reset_token_expiration_date', '>', now)
            .select(
                'users.id',
                'users.email',
                { fullName: 'users.full_name' },
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
