import { FORBIDDEN } from 'http-status';
import { HttpException } from './HttpException';
import { ERROR_CODE } from './error.enum';

export class ForbiddenException extends HttpException {
    constructor(msg = 'You do not have permission to access this resource') {
        super(msg, ERROR_CODE.FORBIDDEN, FORBIDDEN);
    }
}
