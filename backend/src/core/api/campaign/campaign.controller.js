import { CampaignService } from 'core/modules/campaign/services/campaign.service';
import { MESSAGE } from 'core/modules/campaign/services/message.enum';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { ForbiddenException } from 'packages/httpException/ForbiddenException';
import { CreateCampaignDto } from '../../modules/campaign/dto';

class Controller {
    constructor() {
        this.service = CampaignService;
    }

    createOne = async req => {
        const { organization_ids } = req.user.payload;

        // check if organization_id in params is in the organization_ids array of the user
        if (!organization_ids.includes(parseInt(req.params.organization_id))) {
            throw new ForbiddenException(MESSAGE.NOT_BELONG_TO_ORGANIZATION);
        }

        const data = await this.service.createOne(
            CreateCampaignDto(req.body),
            req.params.organization_id,
        );

        return ValidHttpResponse.toCreatedResponse(data);
    };
}

export const CampaignController = new Controller();
