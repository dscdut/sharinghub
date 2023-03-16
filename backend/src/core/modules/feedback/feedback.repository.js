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

    
    findFeedbackByCampaignId(id) {
        return this.query()
            .where('campaign_id', '=', id)
            .select(
                'id',
                { locationRate: 'location_rate' },
                'traffic',
                'weather',
                'sanitization',
                'residence',
                { authorityCooperation: 'authority_cooperation' },
                'others'
            ).from('feedbacks');
    };

    findFeedbackImagesByFeedbackId(id) {
        return this.query()
            .where('feedback_images.feedback_id', '=', id)
            .select('feedback_images.image')
            .from('feedback_images');
    }


}

export const FeedbackRepository = new Repository('organizations');
