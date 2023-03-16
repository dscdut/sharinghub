import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    createOrg(org) {
        return this.query().insert(org).into('organizations').returning('id');
    }

    updateOrg(org) {
        return this.query()
            .where('id', '=', org.id)
            .where('user_id', '=', org.user_id)
            .update({
                name: org.name,
                phone_number: org.phone_number,
                address: org.address,
                description: org.description,
                avatar: org.avatar,
            })
            .into('organizations')
            .returning('id');
    }

    findUsersOrgsById(id) {
        return this.query()
            .where('organizations.user_id', '=', id)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
                'organizations.avatar'
            );
    }

    findOrgByName(name) {
        return this.query()
            .whereRaw('username like ?', `%${name}%`)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
                'organizations.avatar'
            );
    }

    findOrgById(id) {
        return this.query()
            .where('organizations.id', '=', id)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
                'organizations.avatar'
            );
    }

    findOrgByExactName(id, name) {
        if (id) {
            return this.query()
                .whereRaw('lower(organizations.name) = ?', name.toLowerCase())
                .where('organizations.id', '!=', id)
                .select(
                    'organizations.id',
                    'organizations.name',
                    { phoneNumber: 'organizations.phone_number' },
                    'organizations.address',
                    'organizations.description',
                    'organizations.avatar'
                );
        }
        return this.query()
            .whereRaw('lower(organizations.name) = ?', name.toLowerCase())
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
                'organizations.avatar'
            );
    }

    findOrgByPhoneNumber(id, phoneNumber) {
        if (id) {
            return this.query()
                .where('organizations.phone_number', '=', phoneNumber)
                .where('organizations.id', '!=', id)
                .select(
                    'organizations.id',
                    'organizations.name',
                    { phoneNumber: 'organizations.phone_number' },
                    'organizations.address',
                    'organizations.description',
                    'organizations.avatar'
                );
        }
        return this.query()
            .where('organizations.phone_number', '=', phoneNumber)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
                'organizations.avatar'
            );
    }

    deleteOrgById(id) {
        return this.query()
            .where('organizations.id', '=', id)
            .delete();
    }
}

export const OrgRepository = new Repository('organizations');
