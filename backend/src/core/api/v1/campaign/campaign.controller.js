import { CampaignService } from 'core/modules/campaign/services/campaign.service';
import { MESSAGE } from 'core/modules/campaign/services/message.enum';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { NotFoundException } from 'packages/httpException';
import { ForbiddenException } from 'packages/httpException/ForbiddenException';
import { CreateCampaignDto } from '../../../modules/campaign/dto';
import { FeedbackService } from '../../../modules/feedback/service/feedback.service';
import { CreateFeedbackDto } from '../../../modules/feedback/dto';
import { logger } from '../../../../packages/logger';

class Controller {
    constructor() {
        this.service = CampaignService;
        this.feedbackService = FeedbackService;
    }

    findOneById = async req => {
        const data = await this.service.findOneById(req.params.id);

        if (!data) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_ID);
        }

        const feedback = await this.feedbackService.getFeedBack(data.id);
        
        return ValidHttpResponse.toOkResponse({ ...data, feedback: feedback ? feedback : null });
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
}

export const CampaignController = new Controller();
