import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    createCampaign(campaign, trx = null) {
        const queryBuilder = this.query().insert(campaign, 'id');

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    findByName(name) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.name', '=', name)
            .first('id');
    }
}

export const CampaignRepository = new Repository('campaigns');
