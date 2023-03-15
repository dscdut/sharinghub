import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findOneByCampaignIdAndVolunteerId(campaign_id, user_id) {
        return this.query()
            .whereNull('users_campaigns.deleted_at')
            .where('users_campaigns.campaign_id', '=', campaign_id)
            .andWhere('users_campaigns.user_id', '=', user_id)
            .first();
    }

    registerVolunteer(campaign_id, user_id, trx) {
        return this.query(trx).insert({
            campaign_id,
            user_id,
        });
    }

    getAllVolunteersByCampaignId(campaign_id, status) {
        return this.query()
            .whereNull('users_campaigns.deleted_at')
            .where('users_campaigns.campaign_id', '=', campaign_id)
            .andWhere('users_campaigns.status', '=', status)
            .join('users', 'users.id', '=', 'users_campaigns.user_id')
            .select([
                'users.id',
                { fullName: 'users.full_name' },
                'users.email',
                'users.birthday',
                { phoneNumber: 'users.phone_number' },
            ]);
    }

    updateVolunteerStatus(campaign_id, user_id, data, trx = null) {
        const queryBuilder = this.query(trx)
            .whereNull('users_campaigns.deleted_at')
            .where('users_campaigns.campaign_id', '=', campaign_id)
            .andWhere('users_campaigns.user_id', '=', user_id)
            .update(data);

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }
}

export const UserCampaignRepository = new Repository('users_campaigns');