import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
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
}

export const CampaignRepository = new Repository('campaigns');
