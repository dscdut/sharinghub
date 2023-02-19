export class HttpException extends Error {
    code;

    status;

    constructor(msg, code, status) {
        super(msg);
        this.code = code;
        this.status = status;
    }
}
