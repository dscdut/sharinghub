import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, userId) {
        return this.query()
            .where('donation_records.id', '=', donationId)
            .where('donation_records.campaign_id', '=', campaignId)
            .where('donation_records.donor_id', '=', userId)
            .first([
                'id',
                { campaignId: 'campaign_id' },
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status'
            ]);
    }

    findDonationByIdAndCampaignId(donationId, campaignId) {
        return this.query()
            .where('donation_records.id', '=', donationId)
            .where('donation_records.campaign_id', '=', campaignId)
            .first([
                'id',
                { campaignId: 'campaign_id' },
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status'
            ]);
    }

    findAllDonationsByCampaignIdAndUserId(campaignId, userId) {
        return this.query()
            .where('donation_records.campaign_id', '=', campaignId)
            .where('donation_records.donor_id', '=', userId)
            .select(
                'id',
                { campaignId: 'campaign_id' },
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status'
            );
    }
    
    createDonation(donation, trx = null) {
        return super.insert(donation, trx).into('donation_records');
    }

    updateDonation(id, donation, trx = null) {
        const queryBuilder = this.query().where({ id }).update(donation);
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    deleteDonation(id, trx = null) {
        const queryBuilder = this.query().where({ id }).delete()
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    insertDonationImages(image, trx = null) {
        const queryBuilder = this.query().insert(image).into('donation_images');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    deleteDonationImages(id, trx = null) {
        const queryBuilder = this.query()
            .where('donation_id', '=', id)
            .delete()
            .into('donation_images');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    findAllDonationImagesById(donationId) {
        return this.query()
            .where('donation_images.donation_id', '=', donationId)
            .select('image')
            .from('donation_images');
    }

    findAllPendingDonations(campaignId) {
        return this.query()
            .where('donation_records.campaign_id', '=', campaignId)
            .where('donation_records.status', '=', 1)
            .select(
                'id',
                { campaignId: 'campaign_id' },
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status'
            );
    }

    updateDonorStatus(donationId, campaignId, status) {
        return this.query()
            .where('donation_records.id', '=', donationId)
            .where('donation_records.campaign_id', '=', campaignId)
            .update({ status });
    }

    findAllDonationByCampaignIdAndStatus(campaignId, status) {
        return this.query()
            .where('donation_records.campaign_id', '=', campaignId)
            .where('donation_records.status', '=', status)
            .select(
                'id',
                { campaignId: 'campaign_id' },
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status'
            );
    }
}

export const DonationRecordRepository = new Repository('donation_records');
