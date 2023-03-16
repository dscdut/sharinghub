import { Optional } from 'core/utils';
import { logger } from '../../../../packages/logger';
import { FeedbackRepository } from '../feedback.repository';
import {
    InternalServerException,
    BadRequestException,
    DuplicateException,
} from '../../../../packages/httpException';

class Service {
    constructor() {
        this.repository = FeedbackRepository;
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
}

export const FeedbackRepositoryService = new Service();
