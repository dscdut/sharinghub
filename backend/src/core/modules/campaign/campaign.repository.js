import { Status, Attend_Role } from '../../common/enum';
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

    findVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('users_campaigns.user_id', '=', id)
            .andWhere('users_campaigns.role', '=', Attend_Role.VOLUNTEER)
            .andWhere('users_campaigns.status', '=', Status.APPROVED)
            .select(
                'campaigns.id',
                'campaigns.name',
                'campaigns.description',
                'campaigns.start_date',
                'campaigns.end_date',
                'campaigns.specificAddress',
                'campaigns.image',
                'users_campaigns.role',
                'organizations.name as organization_name',
            );
    }
}

export const CampaignRepository = new Repository('campaigns');
