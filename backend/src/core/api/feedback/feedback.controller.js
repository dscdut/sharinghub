import { FeedbackService } from '../../modules/feedback/service/feedback.service';

class Controller {
    constructor() {
        this.service = FeedbackService;
    }

    createFeedback = async req => {
        const data = await this.service.createFeedback(LoginDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };
    
    getFeedback = async req => {
        const data = await this.service.getFeedBack(req.params);
        return ValidHttpResponse.toOkResponse(data);
    };
};

export const FeedbackController = new Controller();