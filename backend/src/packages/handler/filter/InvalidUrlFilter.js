import { InValidHttpResponse } from '../response/invalidHttp.response';

export class InvalidUrlFilter {
    filter(req, res) {
        return InValidHttpResponse.toNotFoundResponse(`Can not get ${req.path}`).toResponse(res);
    }
}
