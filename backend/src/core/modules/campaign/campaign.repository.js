import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    createCampaign(campaign) {
        return this.query().insert(campaign).into('campaigns');
    }

    findByName(name) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.name', '=', name)
            .first('id');
    }
}

export const CampaignRepository = new Repository('campaigns');
