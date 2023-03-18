import { FeedbackService } from '../../../modules/feedback/service/feedback.service';
import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { CreateFeedbackDto } from '../../../modules/feedback/dto';

class Controller {
    constructor() {
        this.service = FeedbackService;
    }

    createOrUpdateFeedback = async req => {
        const data = await this.service.createOrUpdateFeedback(req, CreateFeedbackDto(req.body), req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    };

    deleteFeedback = async req => {
        const data = await this.service.deleteFeedback(req.user.payload, req.params);
        return ValidHttpResponse.toOkResponse(data);
    }
};

export const FeedbackController = new Controller();