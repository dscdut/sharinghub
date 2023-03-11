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
            })
            .into('organizations')
            .returning('id');
    }

    findUsersOrgsById(id) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .where('organizations.user_id', '=', id)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
            );
    }

    findOrgByName(name) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .whereRaw('username like ?', `%${name}%`)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
            );
    }

    findOrgById(id) {
        return this.query()
            .whereNull('organizations.deleted_at')
            .where('organizations.id', '=', id)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
            );
    }

    findOrgByExactName(id, name) {
        if (id) {
            return this.query()
                .whereNull('organizations.deleted_at')
                .whereRaw('lower(organizations.name) = ?', name.toLowerCase())
                .where('organizations.id', '!=', id)
                .select(
                    'organizations.id',
                    'organizations.name',
                    { phoneNumber: 'organizations.phone_number' },
                    'organizations.address',
                    'organizations.description',
                );
        }
        return this.query()
            .whereNull('organizations.deleted_at')
            .whereRaw('lower(organizations.name) = ?', name.toLowerCase())
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
            );
    }

    findOrgByPhoneNumber(id, phoneNumber) {
        if (id) {
            return this.query()
                .whereNull('organizations.deleted_at')
                .where('organizations.phone_number', '=', phoneNumber)
                .where('organizations.id', '!=', id)
                .select(
                    'organizations.id',
                    'organizations.name',
                    { phoneNumber: 'organizations.phone_number' },
                    'organizations.address',
                    'organizations.description',
                );
        }
        return this.query()
            .whereNull('organizations.deleted_at')
            .where('organizations.phone_number', '=', phoneNumber)
            .select(
                'organizations.id',
                'organizations.name',
                { phoneNumber: 'organizations.phone_number' },
                'organizations.address',
                'organizations.description',
            );
    }

    deleteOrgById(id) {
        return this.query()
            .where('id', '=', id)
            .update({
                deleted_at: new Date(),
            })
            .into('organizations')
    }
}

export const OrgRepository = new Repository('organizations');
