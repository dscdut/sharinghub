import { OrgRepositoryService } from '../../org/service/org-repository.service';
import { CampaignService } from '../../campaign/services/campaign.service';
import { InternalServerException, NotFoundException } from 'packages/httpException';
import { FeedbackRepositoryService } from './feedback-repository.service';
class Service {
    constructor() {
        this.orgRepositoryService = OrgRepositoryService;
        this.campaignService = CampaignService;
        this.FeedbackRepositoryService = FeedbackRepositoryService;
    }
    async getFeedBack(campaignId) {
        const feedback = await this.FeedbackRepositoryService.findFeedbackByCampaignId(campaignId);

        if (feedback) {
            const images = (await this.FeedbackRepositoryService.findFeedbackImagesByFeedbackId(feedback.id)).map(image => image.image);
            return {
                ...feedback,
                images,
            };
        }
    }
};

export const FeedbackService = new Service();