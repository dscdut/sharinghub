import { logger } from '../../../../packages/logger';
import { DonationRecordRepository } from '../donation-record.repository';
import { InternalServerException } from '../../../../packages/httpException';
import { getTransaction } from 'core/database';
import { FileSystemService, MediaService } from 'core/modules/document';

class Service {
    constructor() {
        this.repository = DonationRecordRepository;
        this.MediaService = MediaService;
        this.FileSystemService = FileSystemService;
    }
    
    async findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, userId) {
        try {
            return this.repository.findDonationByIdAndCampaignIdAndUserId(donationId, campaignId, userId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
    
    async findDonationByIdAndCampaignId(donationId, campaignId) {
        try {
            return this.repository.findDonationByIdAndCampaignId(donationId, campaignId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async deleteFile(files) {
        try {
            for (const file of files) {
                await this.FileSystemService.deleteFile(file);
            }
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async insertDonationImages(donation_id, campaign_id, images, trx) {
        try {
            for (const image of images) {
                const url = (await this.MediaService.uploadOne(image, `users/donations/${campaign_id}/${donation_id}`)).url;
               
                await this.repository.insertDonationImages({ donation_id, image: url }, trx);
            }
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }
    }

    async deleteDonationImages(id, trx) {
        try {
            await this.repository.deleteDonationImages(id, trx);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }

    }

    async createDonation(images, data) {
        const trx = await getTransaction();
        try {
            const [{ id }] = await this.repository.createDonation(data, trx);

            await this.insertDonationImages(id, data.campaign_id, images, trx);
            
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        await trx.commit();
    }

    async updateDonation(images, id, data) {
        const trx = await getTransaction();

        try {
            await this.repository.updateDonation(id, data, trx);

            await this.deleteDonationImages(id, trx);

            await this.insertDonationImages(id, data.campaign_id, images, trx);
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
    }

    async deleteDonationById(id) {
        const trx = await getTransaction();

        try {
            await this.repository.deleteDonation(id, trx);

            await this.repository.deleteDonationImages(id, trx);
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
        
        trx.commit();
    }

    async findAllDonationsByCampaignIdAndUserId(campaignId, userId) {
        try {
            return this.repository.findAllDonationsByCampaignIdAndUserId(campaignId, userId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findAllPendingDonations(campaignId) {
        try {
            return this.repository.findAllPendingDonations(campaignId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findAllDonationImagesById(donationId) {
        try {
            return this.repository.findAllDonationImagesById(donationId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateDonorStatus(donationId, campaignId, status) {
        try {
            return this.repository.updateDonorStatus(donationId, campaignId, status);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findAllDonationByCampaignIdAndStatus(campaignId, status) {
        try {
            return this.repository.findAllDonationByCampaignIdAndStatus(campaignId, status);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

}

export const DonationRecordRepositoryService = new Service();
