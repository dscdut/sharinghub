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

        // try {
        //     const result = await this.query.getTransaction(async (trx) => {
        //         // insert a row into the users table and get the user ID
        //         const [userId] = await trx('users').insert(user).returning('id');
        //         // insert a row into the posts table with the user ID as the foreign key
        //         await trx('posts').insert({ ...post, user_id: userId });
        //         return 'Data inserted successfully';
        //     });
        //     console.log(result);
        // } catch (error) {
        //     console.error(error);
        // }
    }
}

export const UserRepository = new Repository('users');
