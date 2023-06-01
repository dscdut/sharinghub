import { UserCampaignRepository } from 'core/modules/user_campaign/user_campaign.repository';
import { CampaignService } from '../../campaign/services/campaign.service';
import { DonationRecordRepository } from 'core/modules/donation/donation-record.repository';
import { ForbiddenException, NotFoundException, BadRequestException } from 'packages/httpException';
import { logger } from '../../../../packages/logger';
import { Optional } from 'core/utils';
import { UserFeedbackRepository } from '../user_feedback.repository';
import { MESSAGE } from './message.enum';
import { UserRepository } from 'core/modules/user/user.repository';

class Service {
    constructor() {
        this.userCampaignRepository = UserCampaignRepository;
        this.campaignService = CampaignService;
        this.repository = UserFeedbackRepository;
        this.donationRecordRepository = DonationRecordRepository;
        this.userRepository = UserRepository;
        this.logger = logger;
    }

    async createOrUpdateUserFeedback(userFeedbackDto, user, { campaignId }) {
        const campaign = Optional.of(await this.campaignService.findOneById(campaignId)).throwIfNotPresent(new NotFoundException('Campaign not found')).get();

        const volunteer = await this.userCampaignRepository.findApprovedVolunteerByCampaignIdAndUserId(campaignId, user.id);

        const donor = await this.donationRecordRepository.findAllApprovedDonationsByCampaignIdAndUserId(campaignId, user.id);
        
        if (!(volunteer.length || donor.length)) {
            throw new ForbiddenException('You didn\'t participate in this campaign');
        }

        if (new Date(campaign.endDate) > new Date()) {
            throw new BadRequestException('The campaign hasn\'t ended yet');
        }

        const existingUserFeedback = await this.repository.findFeedbackByCampaignIdAndUserId(campaignId, user.id);

        if (!existingUserFeedback) {
            await this.repository.createUserFeedback({ ...userFeedbackDto, campaign_id: campaignId, user_id: user.id });
            
            return {
                message: MESSAGE.CREATE_FEEDBACK_SUCCESS
            }
        } else {
            await this.repository.updateUserFeedback(userFeedbackDto, campaignId, user.id);
            
            return {
                message: MESSAGE.UPDATE_FEEDBACK_SUCCESS
            }
        }
    }

    async getUserFeedbacksByCampaignId(campaignId) {
       return this.repository.findFeedbacksByCampaignId(campaignId);
    }

    async getUserFeedbackByCampaignIdAndUserId( { campaignId, userId }) {
        const userFeedback = Optional.of(await this.repository.findFeedbackByCampaignIdAndUserId(campaignId, userId)).throwIfNotPresent(new NotFoundException('User feedback not found')).get();

        return {
            data: {
                userFeedback
            }
        }
    }
    
    async deleteUserFeedback(user, { campaignId }) {
        Optional.of(await this.repository.findFeedbackByCampaignIdAndUserId(campaignId, user.id)).throwIfNotPresent(new NotFoundException('User feedback not found'));

        await this.repository.deleteFeedbackByCampaignIdAndUserId(campaignId, user.id);

        return {
            message: MESSAGE.DELETE_FEEDBACK_SUCCESS
        }
        
    }
};

export const UserFeedbackService = new Service();
