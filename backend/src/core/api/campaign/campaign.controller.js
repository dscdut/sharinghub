import { Status } from 'core/common/enum';
import { CampaignService } from 'core/modules/campaign/services/campaign.service';
import { MESSAGE } from 'core/modules/campaign/services/message.enum';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { NotFoundException } from 'packages/httpException';
import { ForbiddenException } from 'packages/httpException/ForbiddenException';
import { CreateCampaignDto } from '../../modules/campaign/dto';
import { UpdateUserStatusDto } from '../../modules/user_campaign/dto';

class Controller {
    constructor() {
        this.service = CampaignService;
    }

    findOneById = async req => {
        const data = await this.service.findOneById(req.params.id);

        if (!data) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_ID);
        }

        return ValidHttpResponse.toOkResponse(data);
    }

    findAllByOrgId = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.findAllByOrgId(
            req.params.organizationId,
        );

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

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.createOne(
            CreateCampaignDto(req.body),
            req.params.organizationId,
        );

        return ValidHttpResponse.toCreatedResponse(data);
    };

    updateOne = async req => {
        const { organization_ids } = req.user.payload;

        // check if organizationId in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organizationId))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.updateOne(
            req.params.organizationId,
            req.params.campaignId,
            CreateCampaignDto(req.body)
        );

        return ValidHttpResponse.toOkResponse(data);
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
}

export const CampaignController = new Controller();
