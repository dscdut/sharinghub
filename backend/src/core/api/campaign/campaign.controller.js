import { CampaignService } from 'core/modules/campaign/services/campaign.service';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { CreateCampaignDto } from '../../modules/campaign/dto';

class Controller {
    constructor() {
        this.service = CampaignService;
    }

    createOne = async req => {
        const data = await this.service.createOne(CreateCampaignDto(req.body));

        return ValidHttpResponse.toCreatedResponse(data);
    };
}

export const CampaignController = new Controller();
