import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';
import { Status } from 'core/common/enum';
import connection from 'core/database';

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

    findAllApprovedDonationsByCampaignIdAndUserId(campaignId, userId) {
        return this.query()
        .where('donation_records.campaign_id', '=', campaignId)
        .andWhere('donation_records.donor_id', '=', userId)
        .andWhere('donation_records.status', '=', Status.APPROVED)
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
        return super.insert({ ...donation, status: 2}, trx).into('donation_records');
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
            .join('users', 'donation_records.donor_id', 'users.id')
            .select(
                'donation_records.id',
                { campaignId: 'campaign_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status',
                { donorId: 'donor_id' },
                { fullName: 'users.full_name' },
                { phoneNumber: 'users.phone_number' },
            );
    }

    findAllDonationsByUserId(userId) {
        console.log(userId)
        return this.query()
            .where('donation_records.donor_id', '=', userId)
            .join('campaigns', 'donation_records.campaign_id', 'campaigns.id')
            .select(
                'donation_records.id',
                { donorId: 'donor_id' },
                { itemName: 'item_name' },
                { quantity: 'quantity' },
                'status',
                { campaign: connection.raw(`json_build_object(
                    'id', campaigns.id, 
                    'name', campaigns.name, 
                    'image', campaigns.image, 
                    'description', campaigns.description,
                    'address', campaigns.address,
                    'specificAddress', campaigns.specific_address,
                    'startDate', campaigns.start_date,
                    'endDate', campaigns.end_date,
                    'donationRequirement', campaigns.donation_requirement,
                    'coordinate', 'campaigns.coordinate'
                )`)}
            );
    }
}

export const DonationRecordRepository = new Repository('donation_records');
