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
import { JwtService } from '../../../modules/auth/service/jwt.service';
import { UserFeedbackService, CreateUserFeedbackDto } from 'core/modules/user_feedback';
import { UserFeedbackRepository } from 'core/modules/user_feedback/user_feedback.repository';

class Controller {
    constructor() {
        this.service = CampaignService;
        this.feedbackService = FeedbackService;
        this.donationService = DonationService;
        this.donationRecordRepositoryService = DonationRecordRepositoryService
        this.jwtService = JwtService;
        this.userFeedbackService = UserFeedbackService;
        this.userFeedbackRepository = UserFeedbackRepository;
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
                phoneNumber: volunteer.phoneNumber ? volunteer.phoneNumber.split('').map((char, index) => index > 2 && index < volunteer.phoneNumber.length - 1 ? '*' : char).join('') : null,
            }
        })

        const donations = await this.donationRecordRepositoryService.findAllDonationByCampaignIdAndStatus(data.id, Status.APPROVED);

        const maskedDonors = donations.map(donation => {
            return {
                fullName: donation.fullName,
                phoneNumber: donation.phoneNumber ? donation.phoneNumber.split('').map((char, index) => index > 2 && index < donation.phoneNumber.length - 1 ? '*' : char).join('') : null,
            }
        })
        
        let joined = false;
        let gaveFeedback = false;

        if (req.headers.authorization) {
            const token = req.headers.authorization.split(' ')[1];

            const { id } = this.jwtService.verify(token);

            volunteers.forEach(volunteer => {
                if (volunteer.id === id) {
                    joined = true;
                }
            });

            donations.forEach(donation => {
                if (donation.donorId === id) {
                    joined = true;
                }
            });

            const userFeedback = await this.userFeedbackRepository.findFeedbackByCampaignIdAndUserId(data.id, id);

            if (userFeedback) {
                gaveFeedback = true;
            }
        }

        const userFeedbacks = await this.userFeedbackService.getUserFeedbacksByCampaignId(data.id);

        const response = { 
            ...data,
            joined,
            gaveFeedback,
            userFeedbacks,
            feedback: feedback ? feedback : null,
            volunteers: maskedVolunteers.slice(0, 3),
            donors: maskedDonors.slice(0, 3)
        }

        return ValidHttpResponse.toOkResponse(response);
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

        const message = await this.service.deleteOne(
            req.params.organizationId,
            req.params.campaignId,
        );

        return ValidHttpResponse.toOkResponse(message);
    }

    deleteOneWithoutAuth = async req => {
        const message = await this.service.deleteOne(
            req.params.organizationId,
            req.params.campaignId,
        );

        return ValidHttpResponse.toOkResponse(message);
    }

    searchByQuery = async req => {
        const data = await this.service.searchByQuery(req.query);
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

    createOrUpdateUserFeedback = async req => {
        const data = await this.userFeedbackService.createOrUpdateUserFeedback(CreateUserFeedbackDto(req.body), req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    }

    deleteUserFeedback = async req => {
        const data = await this.userFeedbackService.deleteUserFeedback(req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    }

    getUserFeedback = async req => {
        const data = await this.userFeedbackService.getUserFeedbackByCampaignIdAndUserId(req.params);
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

    removeNameConstraint = async req => {
        const data = await this.service.removeNameConstraint();
        return ValidHttpResponse.toOkResponse(data);
    }
}

export const CampaignController = new Controller();
