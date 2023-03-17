import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findOneById(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', id)
            .join('organizations', 'campaigns.organization_id', 'organizations.id')
            .first([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { registerLink: 'campaigns.register_link' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
                { organizationName: 'organizations.name' }
            ]);
    }

    findAllByOrgId(organization_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.organization_id', '=', organization_id)
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
            ])
    }

    findOneByOrgIdAndCampaignId(organization_id, campaign_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', campaign_id)
            .where('campaigns.organization_id', '=', organization_id)
            .first([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { registerLink: 'campaigns.register_link' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
            ]);
    }

    findByName(name) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.name', '=', name)
            .first('id');
    }

    updateOne(id, data, trx = null) {
        const queryBuilder = this.query()
            .whereNull('deleted_at')
            .where({ id })
            .update(data)
            .returning('*');

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    hardDeleteOne(id, trx = null) {
        const queryBuilder = this.query()
            .where('id', '=', id)
            .del();

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    searchByName(name = "") {
        return this.query()
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .whereNull('campaigns.deleted_at')
            .whereILike('campaigns.name', `%${name}%`)
            .orWhereILike('organizations.name', `%${name}%`)
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.coordinate',
                { donationRequirement: 'campaigns.donation_requirement' },
                { organizationId: 'campaigns.organization_id' },
                { organizationName: 'organizations.name' }
            ]);
    }

    searchByCoordinate(lng, lat) {
        return this.query()
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .whereNull('campaigns.deleted_at')
            .whereRaw('coordinate->> \'lng\' = ?', [lng])
            .andWhereRaw('coordinate->> \'lat\' = ?', [lat])
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.coordinate',
                { donationRequirement: 'campaigns.donation_requirement' },
                { organizationId: 'campaigns.organization_id' },
                { organizationName: 'organizations.name' }
            ]);
    }

    getAllCoordinates() {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .whereRaw('campaigns.end_date > now()')
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.coordinate',
            ]);
    }

    findVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('users_campaigns.user_id', '=', id)
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                'users_campaigns.status',
                { organizationName: 'organizations.name' },
            );
    }
}

export const CampaignRepository = new Repository('campaigns');
