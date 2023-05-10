import { OrgRepositoryService } from '../../org/service/org-repository.service';
import { CampaignService } from '../../campaign/services/campaign.service';
import { ForbiddenException, NotFoundException, BadRequestException } from 'packages/httpException';
import { FeedbackRepositoryService } from './feedback-repository.service';
import { MESSAGE } from './message.enum';
import { logger } from '../../../../packages/logger';


class Service {
    constructor() {
        this.orgRepositoryService = OrgRepositoryService;
        this.campaignService = CampaignService;
        this.FeedbackRepositoryService = FeedbackRepositoryService;
        this.logger = logger;
    }
    async getFeedBack(campaignId) {
        const feedback = await this.FeedbackRepositoryService.findFeedbackByCampaignId(campaignId);

        if (feedback) {
            const images = (await this.FeedbackRepositoryService.findFeedbackImagesByFeedbackId(feedback.id)).map(image => image.image);

            return { ...feedback, image: images};
        }
    }

    async createOrUpdateFeedback({file, files}, feedbackDto, user, { campaignId }) {
        const images = file ? [file] : files ? files : [];

        try {
            const campaign = await this.campaignService.findOneById(campaignId);

            if (!campaign) {
                throw new NotFoundException('Campaign not found');
            }

            if (!user.organization_ids.includes(campaign.organizationId)) {
                throw new ForbiddenException('You don\'t have permission to create or edit feedback for this campaign');
            }

            if (new Date(campaign.end_date) < new Date()) {
                throw new BadRequestException('The campaign hasn\'t ended yet');
            }

            const existingFeedback = await this.FeedbackRepositoryService.findFeedbackByCampaignId(campaignId);

            if (!existingFeedback) {
                await this.FeedbackRepositoryService.createFeedback(feedbackDto, campaign.id, campaign.organizationId, images);
                
                return {
                    message: MESSAGE.CREATE_FEEDBACK_SUCCESS
                }
            } else {
                await this.FeedbackRepositoryService.updateFeedback(existingFeedback.id, feedbackDto, campaign.id, campaign.organizationId, images);
                
                return {
                    message: MESSAGE.UPDATE_FEEDBACK_SUCCESS
                }
            }            
        } catch(error) {
            this.FeedbackRepositoryService.deleteFile(images);
            logger.error(error.message);
            throw error;
        }
    }

    async deleteFeedback(user, { campaignId }) {
        const campaign = await this.campaignService.findOneById(campaignId);

        if (!campaign) {
            throw new NotFoundException('Campaign not found');
        }

        if (!user.organization_ids.includes(campaign.organizationId)) {
            throw new ForbiddenException('You don\'t have permission to delete feedback for this campaign');
        }

        const existingFeedback = await this.FeedbackRepositoryService.findFeedbackByCampaignId(campaignId);

        if (!existingFeedback) {
            throw new NotFoundException('Feedback not found');
        }
        
        await this.FeedbackRepositoryService.deleteFeedback(existingFeedback.id);
            
        return {
            message: MESSAGE.DELETE_FEEDBACK_SUCCESS
        }          
    }
};

export const FeedbackService = new Service();
