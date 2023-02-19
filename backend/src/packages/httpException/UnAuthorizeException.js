import { UNAUTHORIZED } from 'http-status';
import { ERROR_CODE } from './error.enum';
import { HttpException } from './HttpException';

export class UnAuthorizedException extends HttpException {
    constructor(msg = 'Invalid access token') {
        super(msg, ERROR_CODE.UNAUTHORIZED, UNAUTHORIZED);
    }
}
