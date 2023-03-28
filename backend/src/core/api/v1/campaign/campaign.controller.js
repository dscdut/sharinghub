import { Status } from 'core/common/enum';
import { CampaignService } from 'core/modules/campaign/services/campaign.service';
import { MESSAGE } from 'core/modules/campaign/services/message.enum';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { NotFoundException } from 'packages/httpException';
import { ForbiddenException } from 'packages/httpException/ForbiddenException';
import { UpdateUserStatusDto } from '../../../modules/user_campaign/dto';
import { CreateCampaignDto } from '../../../modules/campaign/dto';
import { FeedbackService } from '../../../modules/feedback/service/feedback.service';
import { CreateFeedbackDto } from '../../../modules/feedback/dto';
import { logger } from '../../../../packages/logger';
import { CreateDonationDto, UpdateDonorsStatusDto } from '../../../modules/donation/dto';
import { DonationService } from '../../../modules/donation/service/donation.service';
import { DonationRecordRepositoryService } from '../../../modules/donation/service/donation-record-repository.service';

class Controller {
    constructor() {
        this.service = CampaignService;
        this.feedbackService = FeedbackService;
        this.donationService = DonationService;
        this.donationRecordRepositoryService = DonationRecordRepositoryService
    }

    findOneById = async req => {
        const data = await this.service.findOneById(req.params.id);

        if (!data) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT);
        }

        const feedback = await this.feedbackService.getFeedBack(data.id);

        const volunteers = await this.service.getAllVolunteersByOrgIdAndCampaignId(data.organizationId, data.id, Status.APPROVED);

        const maskedVolunteers = volunteers.map(volunteer => {
            return {
                fullName: volunteer.fullName,
                phoneNumber: `${volunteer.phoneNumber.substring(0, 3)}***${volunteer.phoneNumber.substring(volunteer.phoneNumber.length - 1)}`
            }
        })

        const donations = await this.donationRecordRepositoryService.findAllDonationByCampaignIdAndStatus(data.id, Status.APPROVED);

        const maskedDonors = donations.map(donation => {
            return {
                donorFullName: donation.donorFullName,
                donorPhoneNumber: `${donation.donorPhoneNumber.substring(0, 3)}***${donation.donorPhoneNumber.substring(donation.donorPhoneNumber.length - 1)}`
            }
        })

        return ValidHttpResponse.toOkResponse({ ...data, feedback: feedback ? feedback : null, volunteers: maskedVolunteers.slice(0, 3), donors: maskedDonors.slice(0, 3)});
    }

    findAllByOrgId = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.findAllByOrgId(req.params.organizationId);

        return ValidHttpResponse.toOkResponse(data);
    }

    findOneByOrgIdAndCampaignId = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.findOneByOrgIdAndCampaignId(
            req.params.organizationId,
            req.params.campaignId,
        );

        if (!data) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND);
        }

        return ValidHttpResponse.toOkResponse(data);
    }

    createOne = async req => {
        const { organization_ids } = req.user.payload;

        const { file } = req;

        try {
            // check if organizationId in params is in the organization_ids array of the user
            if (!organization_ids.includes(parseInt(req.params.organizationId))) {
                throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
            }

            const data = await this.service.createOne(CreateCampaignDto(req.body), req.params.organizationId, file);

            return ValidHttpResponse.toCreatedResponse(data);
        } catch(error) {
            this.service.deleteFile(file);
            logger.error(error.message);
            throw error;
        }
    };

    updateOne = async req => {
        const { organization_ids } = req.user.payload;

        const { file } = req;

        try {
            // check if organizationId in params is in the organization_ids array of the user
            if (!organization_ids.includes(parseInt(req.params.organizationId))) {
                throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
            }
        
            const data = await this.service.updateOne(
                req.params.organizationId,
                req.params.campaignId,
                CreateCampaignDto(req.body),
                file
            );
            
            return ValidHttpResponse.toOkResponse(data);
        } catch(error) { 
            this.service.deleteFile(file);
            logger.error(error.message);
            throw error;
        }

    }

    deleteOne = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        await this.service.deleteOne(
            req.params.organizationId,
            req.params.campaignId,
        );

        return ValidHttpResponse.toNoContentResponse();
    }

    searchByQuery = async req => {
        const { name, lng, lat } = req.query;

        let data = [];
        if (name && !lng && !lat) {
            data = await this.service.searchByName(name);
        } else if (!name && lng && lat) {
            data = await this.service.searchByCoordinate(lng, lat);
        }
        else {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT);
        }

        return ValidHttpResponse.toOkResponse(data);
    }

    registerVolunteer = async req => {
        const data = await this.service.registerVolunteer(req.params.id, req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    }

    getAllVolunteersByOrgIdAndCampaignId = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.getAllVolunteersByOrgIdAndCampaignId(req.params.organizationId, req.params.campaignId, Status.APPROVED);
        return ValidHttpResponse.toOkResponse(data);
    }

    getAllPendingVolunteersByOrgIdAndCampaignId = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.getAllVolunteersByOrgIdAndCampaignId(req.params.organizationId, req.params.campaignId, Status.PENDING);
        return ValidHttpResponse.toOkResponse(data);
    }

    updateVolunteerStatus = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.updateVolunteerStatus(
            req.params.organizationId,
            req.params.campaignId,
            req.params.volunteerId,
            UpdateUserStatusDto(req.body)
        );
        return ValidHttpResponse.toOkResponse(data);
    }

    setPendingVolunteersStatusToRejected = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.setPendingVolunteersStatusToRejected(
            req.params.organizationId,
            req.params.campaignId,
        );
        return ValidHttpResponse.toOkResponse(data);
    }

    getAllCoordinates = async req => {
        const data = await this.service.getAllCoordinates();
        return ValidHttpResponse.toOkResponse(data);
    }

    createOrUpdateFeedback = async req => {
        const data = await this.feedbackService.createOrUpdateFeedback(req, CreateFeedbackDto(req.body), req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    };

    deleteFeedback = async req => {
        const data = await this.feedbackService.deleteFeedback(req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    }

    createOrUpdateDonation = async req => {
        const data = await this.donationService.createOrUpdateDonation(req.params, req.user.payload.id, CreateDonationDto(req.body), req);
        return ValidHttpResponse.toOkResponse(data);
    }

    getDonations = async req => {
        const data = await this.donationService.getDonations(req.params.campaignId, req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    }

    getDonation = async req => {
        const data = await this.donationService.getDonation(req.params.donationId, req.params.campaignId, req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    }

    deleteDonation = async req => {
        const data = await this.donationService.deleteDonation(req.params.donationId, req.params.campaignId, req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    }

    getPendingDonors = async req => {
        const data = await this.donationService.getPendingDonors(req.params.organizationId, req.params.campaignId, req.user.payload);
        return ValidHttpResponse.toOkResponse(data);
    }

    updateDonorsStatus = async req => {
        const data = await this.donationService.updateDonorsStatus(req.params.organizationId, req.params.campaignId, req.params.donationId, req.user.payload, UpdateDonorsStatusDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    }

    setPendingDonorsStatusToRejected = async req => {
        const data = await this.donationService.setPendingDonorsStatusToRejected(req.params.organizationId, req.params.campaignId, req.user.payload);
        return ValidHttpResponse.toOkResponse(data);
    }

    getDonors = async req => {
        const data = await this.donationService.getDonors(req.params.organizationId, req.params.campaignId, req.user.payload);
        return ValidHttpResponse.toOkResponse(data);
    }
}

export const CampaignController = new Controller();
