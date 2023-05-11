import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';
import { Status } from 'core/common/enum/user-campaign-status'

class Repository extends DataRepository {
    findOneById(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', id)
            .join('organizations', 'campaigns.organization_id', 'organizations.id')
            .first([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { registerLink: 'campaigns.register_link' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
                { organizationName: 'organizations.name' },
                { organizationId: 'campaigns.organization_id' },
                { organizationAvatar: 'organizations.avatar' } 
            ]);
    }

    findAllByOrgId(organization_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.organization_id', '=', organization_id)
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
            ])
    }

    findOneByOrgIdAndCampaignId(organization_id, campaign_id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.id', '=', campaign_id)
            .where('campaigns.organization_id', '=', organization_id)
            .first([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { registerLink: 'campaigns.register_link' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
            ]);
    }

    findByName(name) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .where('campaigns.name', '=', name)
            .first('id');
    }

    updateOne(id, data, trx = null) {
        const queryBuilder = this.query()
            .whereNull('deleted_at')
            .where({ id })
            .update(data)
            .returning([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                { registerLink: 'campaigns.register_link' },
                { donationRequirement: 'campaigns.donation_requirement' },
                'campaigns.coordinate',
            ]);

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    hardDeleteOne(id, trx = null) {
        const queryBuilder = this.query()
            .where('id', '=', id)
            .del();

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    searchByName(name = "") {
        return this.query()
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .whereNull('campaigns.deleted_at')
            .whereILike('campaigns.name', `%${name}%`)
            .orWhereILike('organizations.name', `%${name}%`)
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.coordinate',
                { donationRequirement: 'campaigns.donation_requirement' },
                { organizationId: 'campaigns.organization_id' },
                { organizationName: 'organizations.name' }
            ]);
    }

    searchByCoordinate(lng, lat) {
        return this.query()
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .whereNull('campaigns.deleted_at')
            .whereRaw('coordinate->> \'lng\' = ?', [lng])
            .andWhereRaw('coordinate->> \'lat\' = ?', [lat])
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.image',
                'campaigns.description',
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.coordinate',
                { donationRequirement: 'campaigns.donation_requirement' },
                { organizationId: 'campaigns.organization_id' },
                { organizationName: 'organizations.name' }
            ]);
    }

    findAllCampaigns() {
        return this.query()
        .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
        .whereNull('campaigns.deleted_at')
        .select([
            'campaigns.id',
            'campaigns.name',
            'campaigns.image',
            'campaigns.description',
            'campaigns.address',
            { specificAddress: 'campaigns.specific_address' },
            { startDate: 'campaigns.start_date' },
            { endDate: 'campaigns.end_date' },
            'campaigns.coordinate',
            { donationRequirement: 'campaigns.donation_requirement' },
            { organizationId: 'campaigns.organization_id' },
            { organizationName: 'organizations.name' },
            { organizationAvatar: 'organizations.avatar'}
        ])
        .orderBy('campaigns.created_at', 'desc');;
    }

    getAllCoordinates() {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .select([
                'campaigns.id',
                'campaigns.name',
                'campaigns.coordinate',
            ])
            .orderBy('campaigns.created_at', 'desc');
    }

    findVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('users_campaigns.user_id', '=', id)
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                'users_campaigns.status',
                { organizationName: 'organizations.name' },
            );
    }
    
    findPendingVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('users_campaigns.user_id', '=', id)
            .andWhere('users_campaigns.status', '=', Status.PENDING)
            .andWhere('campaigns.start_date', '>=', new Date())
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                { organizationName: 'organizations.name' },
            );
    }

    findPendingDonativeCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('donation_records', 'campaigns.id', '=', 'donation_records.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('donation_records.donor_id', '=', id)
            .andWhere('donation_records.status', '=', Status.PENDING)
            .andWhere('campaigns.start_date', '>=', new Date())
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                { organizationName: 'organizations.name' },
            );
    }

    findParticipatedOngoingVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .where('users_campaigns.user_id', '=', id)
            .andWhere('users_campaigns.status', '=', Status.APPROVED)
            .andWhere('campaigns.start_date', '<=', new Date().toISOString())
            .andWhere('campaigns.end_date', '>=', new Date().toISOString())
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                { organizationName: 'organizations.name' },
            );
    }

    findParticipatedOngoingDonativeCampaignsByUserId(id) {
        return this.query()
        .whereNull('campaigns.deleted_at')
        .join('donation_records', 'campaigns.id', '=', 'donation_records.campaign_id')
        .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
        .where('donation_records.donor_id', '=', id)
        .andWhere('donation_records.status', '=', Status.APPROVED)
        .andWhere('campaigns.start_date', '<=', new Date().toISOString())
        .andWhere('campaigns.end_date', '>=', new Date().toISOString())
        .select(
            'campaigns.id',
            'campaigns.name',
            { startDate: 'campaigns.start_date' },
            { endDate: 'campaigns.end_date' },
            'campaigns.address',
            { specificAddress: 'campaigns.specific_address' },
            'campaigns.image',
            { organizationName: 'organizations.name' },
        );
    }

    findParticipatedEndedVoluntaryCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('users_campaigns', 'campaigns.id', '=', 'users_campaigns.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .leftJoin('organizations_reviews', 'organizations.id', '=', 'organizations_reviews.organization_id')
            .where('users_campaigns.user_id', '=', id)
            .andWhere('users_campaigns.status', '=', Status.APPROVED)
            .andWhere('campaigns.end_date', '<', new Date().toISOString())
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                { organizationName: 'organizations.name' },
                'organizations_reviews.rate',
                'organizations_reviews.content',
            );
    }

    findParticipatedEndedDonativeCampaignsByUserId(id) {
        return this.query()
            .whereNull('campaigns.deleted_at')
            .join('donation_records', 'campaigns.id', '=', 'donation_records.campaign_id')
            .join('organizations', 'campaigns.organization_id', '=', 'organizations.id')
            .leftJoin('organizations_reviews', 'organizations.id', '=', 'organizations_reviews.organization_id')
            .where('donation_records.donor_id', '=', id)
            .andWhere('donation_records.status', '=', Status.APPROVED)
            .andWhere('campaigns.end_date', '<', new Date().toISOString())
            .select(
                'campaigns.id',
                'campaigns.name',
                { startDate: 'campaigns.start_date' },
                { endDate: 'campaigns.end_date' },
                'campaigns.address',
                { specificAddress: 'campaigns.specific_address' },
                'campaigns.image',
                { organizationName: 'organizations.name' },
                'organizations_reviews.rate',
                'organizations_reviews.content',
            );
    }

    removeNameConstraint() {
        return super.removeNameConstraint();
    }
}

export const CampaignRepository = new Repository('campaigns');
