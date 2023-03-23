import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {

    createFeedback(feedback, trx) {
        return super.insert(feedback, trx).into('feedbacks');
    }
    
    updateFeedback(id, feedback, trx = null) {
        const queryBuilder = this.query().where({ id }).update(feedback).into('feedbacks');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    deleteFeedback(id, trx = null) {
        const queryBuilder = this.query()
            .where('id', '=', id)
            .delete()
            .into('feedbacks');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    insertFeedbackImages(image, trx = null) {
        const queryBuilder = this.query().insert(image).into('feedback_images');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    deleteFeedbackImages(id, trx = null) {
        const queryBuilder = this.query()
            .where('feedback_id', '=', id)
            .delete()
            .into('feedback_images');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
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
