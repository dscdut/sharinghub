import { getTransaction } from 'core/database';
import { logger } from 'core/utils';
import { NotFoundException, BadRequestException, ForbiddenException } from 'packages/httpException';
import { Optional } from 'core/utils';
import { MESSAGE } from '../../campaign/services/message.enum';
import { CampaignRepository } from '../../campaign/campaign.repository';
import { Status } from '../../../common/enum';
import { UserRepository } from '../../user/user.repository';
import { FileSystemService, MediaService } from 'core/modules/document';
import { CampaignService } from '../../campaign/services/campaign.service';
import { DonationRecordRepositoryService } from './donation-record-repository.service';

class Service {
    constructor() {
        this.repository = CampaignRepository;
        this.userRepository = UserRepository
        this.fileSystemService = FileSystemService;
        this.mediaService = MediaService;
        this.campaignService = CampaignService;
        this.donationRecordRepositoryService = DonationRecordRepositoryService;
    }

    async createOrUpdateDonation({ campaignId, donationId }, user_id, RegisterDonorDto, { file, files }) {
        const images = file ? [file] : files ? files : [];
        
        try {
            const campaign = Optional.of(await this.campaignService.findOneById(campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT)).get();

            if (new Date() > new Date(campaign.startDate)) {
                throw new BadRequestException(MESSAGE.CAMPAIGN_ALREADY_STARTED);
            }

            if (!donationId) {                
                await this.donationRecordRepositoryService.createDonation(images, { ...RegisterDonorDto, campaign_id: campaignId, donor_id: user_id });
                
                return {
                    message: MESSAGE.CREATE_DONATION_SUCCESS
                }
            } else {
                Optional.of(await this.donationRecordRepositoryService.findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, user_id)).throwIfNotPresent(new NotFoundException(MESSAGE.DONATION_NOT_FOUND));

                await this.donationRecordRepositoryService.updateDonation(images, donationId, { ...RegisterDonorDto, campaign_id: campaignId, donor_id: user_id });
                
                return {
                    message: MESSAGE.UPDATE_DONATION_SUCCESS
                }
            }
        } catch (error) {
            this.donationRecordRepositoryService.deleteFile(images);
            logger.error(error.message);
            throw error;
        }
    }

    async getDonations(campaignId, userId) {
        const donations = await this.donationRecordRepositoryService.findAllDonationsByCampaignIdAndUserId(campaignId, userId);

        return Promise.all(donations.map( async (donation) => {
            return {
                ...donation,
                images: (await this.donationRecordRepositoryService.findAllDonationImagesById(donation.id)).map(image => image.image)
            }
        }));
    }
    
    async getDonation(donationId, campaignId, userId) {
        const donation = await this.donationRecordRepositoryService.findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, userId);
        if (!donation) {
            throw new NotFoundException(MESSAGE.DONATION_NOT_FOUND);
        }
        return donation;
    }
    
    async deleteDonation(donationId, campaignId, userId) {
        Optional.of(await this.campaignService.findOneById(campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT));

        const existingDonation = await this.donationRecordRepositoryService.findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, userId);

        if (!existingDonation) {
            throw new NotFoundException(MESSAGE.DONATION_NOT_FOUND);
        }
        
        await this.donationRecordRepositoryService.deleteDonationById(existingDonation.id);
            
        return {
            message: MESSAGE.DELETE_DONATION_SUCCESS
        }          
    }

    async getPendingDonors(orgId, campaignId, user) {
        if (!user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }
        Optional.of(await this.campaignService.findOneByOrgIdAndCampaignId(orgId, campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));
        
        return this.donationRecordRepositoryService.findAllPendingDonations(campaignId);
    }
    
    async updateDonorsStatus(orgId, campaignId, donationId, user, { status }) {
        if (!user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }
        Optional.of(await this.campaignService.findOneByOrgIdAndCampaignId(orgId, campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));

        const donation = await this.donationRecordRepositoryService.findDonationByIdAndCampaignId(donationId, campaignId);

        Optional.of(donation).throwIfNotPresent(new NotFoundException(MESSAGE.DONATION_NOT_FOUND));

        await this.donationRecordRepositoryService.updateDonorStatus(donationId, campaignId, status);

        return {
            message: MESSAGE.UPDATE_DONATION_STATUS_SUCCESS,
            donation: await this.donationRecordRepositoryService.findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, donation.donorId)
        }
    }

    async setPendingDonorsStatusToRejected(orgId, campaignId, user) {
        if (!user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }
        Optional.of(await this.campaignService.findOneByOrgIdAndCampaignId(orgId, campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));
        
        const pendingDonors = await this.donationRecordRepositoryService.findAllPendingDonations(campaignId);

        await Promise.all(pendingDonors.map(async (donor) => {
            await this.donationRecordRepositoryService.updateDonorStatus(donor.id, campaignId, Status.REJECTED);
        }));
        
        return {
            message: MESSAGE.SET_PENDING_DONATIONS_STATUS_TO_REJECTED_SUCCESS
        }
    }

    async getDonors(orgId, campaignId, user) {
        if (!user.organization_ids.includes(Number(orgId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }
        Optional.of(await this.campaignService.findOneByOrgIdAndCampaignId(orgId, campaignId)).throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));
    
        return this.donationRecordRepositoryService.findAllDonationByCampaignIdAndStatus(campaignId, Status.APPROVED);
    }
};

export const DonationService = new Service();
