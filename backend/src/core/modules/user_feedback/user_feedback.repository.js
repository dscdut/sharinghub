import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';
import connection from 'core/database';

class Repository extends DataRepository {
    findFeedbackByCampaignIdAndUserId(campaignId, userId) {
        return this.query()
            .where('users_feedbacks.campaign_id', '=', campaignId)
            .andWhere('users_feedbacks.user_id', '=', userId)
            .join('users', 'users.id', '=', 'users_feedbacks.user_id')
            .first([
                { campaignId: 'users_feedbacks.campaign_id' },
                { organizationRate: 'users_feedbacks.organization_rate' },
                { organizationFeedback: 'users_feedbacks.organization_feedback' },
                { campaignRate: 'users_feedbacks.campaign_rate' },
                { campaignFeedback: 'users_feedbacks.campaign_feedback' },
                { user: connection.raw(`json_build_object(
                    'id', users.id, 
                    'fullName', users.full_name, 
                    'email', users.email, 
                    'phoneNumber', users.phone_number,
                    'avatar', users.avatar,
                    'birthday', users.birthday,
                    'address', users.address,
                    'workplace', users.workplace,
                    'gender', users.gender
                )`)}
            ]);
    }

    createUserFeedback(userFeedbackDto) {
        return this.query().insert(userFeedbackDto);
    }

    updateUserFeedback(userFeedbackDto, campaignId, userId) {
        return this.query()
            .where('users_feedbacks.campaign_id', '=', campaignId)
            .andWhere('users_feedbacks.user_id', '=', userId)
            .update(userFeedbackDto);
    }

    findFeedbacksByCampaignId(campaignId) {
        return this.query()
            .where('users_feedbacks.campaign_id', '=', campaignId)
            .select([
                { campaignId: 'users_feedbacks.campaign_id' },
                { userId: 'users_feedbacks.user_id' },
                { organizationRate: 'users_feedbacks.organization_rate' },
                { organizationFeedback: 'users_feedbacks.organization_feedback' },
                { campaignRate: 'users_feedbacks.campaign_rate' },
                { campaignFeedback: 'users_feedbacks.campaign_feedback' },
            ]);
    }

    deleteFeedbackByCampaignIdAndUserId(campaignId, userId) {
        return this.query()
            .where('users_feedbacks.campaign_id', '=', campaignId)
            .andWhere('users_feedbacks.user_id', '=', userId)
            .delete();
    }
}

export const UserFeedbackRepository = new Repository('users_feedbacks');
