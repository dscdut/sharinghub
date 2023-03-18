import { OrgRepositoryService } from '../../org/service/org-repository.service';
import { CampaignService } from '../../campaign/services/campaign.service';
import { ForbiddenException, DuplicateException, NotFoundException, BadRequestException } from 'packages/httpException';
import { FeedbackRepositoryService } from './feedback-repository.service';
import { MESSAGE } from './message.enum';
import { Optional } from 'core/utils';
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

            return { ...feedback, images };
        }
    }

    async createFeedback({file, files}, feedbackDto, user, { campaignId }) {
        const images = file ? [file] : files ? files : [];

        try {
            const campaign = await this.campaignService.findOneById(campaignId);

            if (!campaign) {
                throw new NotFoundException('Campaign not found');
            }

            if (!user.organization_ids.includes(campaign.organizationId)) {
                throw new ForbiddenException('You don\'t have permission to create a feedback for this campaign');
            }

            if (new Date(campaign.end_date) < new Date()) {
                throw new BadRequestException('The campaign hasn\'t ended yet');
            }

            Optional.of(await this.FeedbackRepositoryService.findFeedbackByCampaignId(campaignId)).throwIfPresent(new DuplicateException('Feedback already exists for this campaign'));

            await this.FeedbackRepositoryService.createFeedback(feedbackDto, campaign.id, campaign.organizationId, images);
            
            return {
                message: MESSAGE.CREATE_FEEDBACK_SUCCESS
            }
        } catch(error) {
            this.FeedbackRepositoryService.deleteFile(images);
            logger.error(error.message);
            throw error;
        }
    }
};

export const FeedbackService = new Service();
