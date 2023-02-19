import { UNPROCESSABLE_ENTITY } from 'http-status';
import { ERROR_CODE } from './error.enum';
import { HttpException } from './HttpException';

export class UnprocessableEntityExeception extends HttpException {
    constructor(msg = 'Unprocessable Entity') {
        super(msg, ERROR_CODE.UNPROCESSABLE_ENTITY, UNPROCESSABLE_ENTITY);
    }
}
