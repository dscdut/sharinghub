import { CREATED, NO_CONTENT, OK } from 'http-status';
import { HttpResponse } from './http.response';

export class ValidHttpResponse extends HttpResponse {
    static toOkResponse(data) {
        return new HttpResponse(OK, data);
    }

    static toNoContentResponse() {
        return new HttpResponse(NO_CONTENT);
    }

    static toCreatedResponse(data) {
        return new HttpResponse(CREATED, data);
    }
}
