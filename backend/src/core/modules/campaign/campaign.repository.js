import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findOneById(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', id)
            .first();
    }

    findAllByOrgId(organization_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.organization_id', '=', organization_id);
    }

    findOneByOrgIdAndCampaignId(organization_id, campaign_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', campaign_id)
            .where('campaigns.organization_id', '=', organization_id)
            .first();
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
            .update(data, 'id');

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
                'campaigns.specificAddress',
                'campaigns.start_date',
                'campaigns.end_date',
                'campaigns.description',
                'campaigns.coordinate',
                'organizations.name as organization_name'
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
                'campaigns.specificAddress',
                'campaigns.start_date',
                'campaigns.end_date',
                'campaigns.description',
                'campaigns.coordinate',
                'organizations.name as organization_name'
            ]);
    }
}

export const CampaignRepository = new Repository('campaigns');
