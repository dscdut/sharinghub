import { NOT_FOUND } from 'http-status';
import { ERROR_CODE } from './error.enum';
import { HttpException } from './HttpException';

export class NotFoundException extends HttpException {
    constructor(msg = 'Not found') {
        super(msg, ERROR_CODE.NOT_FOUND, NOT_FOUND);
    }
}
