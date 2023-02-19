import { InValidHttpResponse } from '../handler/response/invalidHttp.response';
import { HttpException } from './HttpException';

export class HttpExceptionFilter {
    filter(err, req, res, next) {
        if (err instanceof HttpException) {
            return new InValidHttpResponse(err.status, err.code, err.message)
                .toResponse(res);
        }
        if (err instanceof Error) {
            return InValidHttpResponse.toInternalResponse(err.message).toResponse(res);
        }
        return next();
    }
}
