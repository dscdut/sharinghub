import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findFeedbackByCampaignIdAndUserId(campaignId, userId) {
        return this.query()
            .where('users_feedbacks.campaign_id', '=', campaignId)
            .andWhere('users_feedbacks.user_id', '=', userId)
            .first([
                { campaignId: 'users_feedbacks.campaign_id' },
                { userId: 'users_feedbacks.user_id' },
                { organizationRate: 'users_feedbacks.organization_rate' },
                { organizationFeedback: 'users_feedbacks.organization_feedback' },
                { campaignRate: 'users_feedbacks.campaign_rate' },
                { campaignFeedback: 'users_feedbacks.campaign_feedback' },
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
