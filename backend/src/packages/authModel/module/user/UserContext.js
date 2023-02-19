import { AUTH_CONTEXT } from '../../common/enum/authContext';

export function getUserContext(req) {
    return req[AUTH_CONTEXT.KEY_AUTH_CONTEXT];
}
