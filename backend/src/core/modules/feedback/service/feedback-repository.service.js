import { logger } from '../../../../packages/logger';
import { FeedbackRepository } from '../feedback.repository';
import { InternalServerException } from '../../../../packages/httpException';
import { getTransaction } from 'core/database';
import { FileSystemService, MediaService } from 'core/modules/document';

class Service {
    constructor() {
        this.repository = FeedbackRepository;
        this.MediaService = MediaService;
        this.FileSystemService = FileSystemService;
    }
    async findFeedbackByCampaignId(campaignId) {
        try {
            const feedback = await this.repository.findFeedbackByCampaignId(campaignId);
            
            return feedback[0];
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
    
    async findFeedbackImagesByFeedbackId(feedbackId) {
        try {
            return this.repository.findFeedbackImagesByFeedbackId(feedbackId);
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

    async createFeedback(feedbackDto, campaignId, organizationId, images) {
        const trx = await getTransaction();

        try {
            const [{ id }] = await this.repository.createFeedback({ ...feedbackDto, campaign_id: campaignId }, trx);
            await this.insertFeedbackImages(id, campaignId, organizationId, images, trx);
        } catch (error) {
            await trx.rollback();
            this.deleteFile(images);
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
    }

    async insertFeedbackImages(feedback_id, campaignId, organizationId, images, trx) {
        try {
            for (const image of images) {
                const url = (await this.MediaService.uploadOne(image, `organizations/${organizationId}/campaigns/${campaignId}`)).url;
                await this.repository.insertFeedbackImages({ feedback_id, image: url }, trx);
            }
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }

    }
}

export const FeedbackRepositoryService = new Service();
