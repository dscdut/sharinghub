import { AUTH_CONTEXT } from '../../common/enum/authContext';
import { JwtValidator } from './JwtValidator';
import { InvalidInstance } from '../../exceptions/InvalidInstance';
import { UserDetail } from '../user/UserDetail';

export class JwtAuthAdapter {
    static USER_DETAIL_CLASS = UserDetail;

    #token;

    #userDetail;

    static builder() {
        return new JwtAuthAdapter();
    }

    static applyCustomUserDetail(customUserDetailClass) {
        if (customUserDetailClass instanceof UserDetail) {
            JwtAuthAdapter.USER_DETAIL_CLASS = customUserDetailClass;
        } else {
            throw new InvalidInstance(customUserDetailClass, JwtAuthAdapter.USER_DETAIL_CLASS);
        }
    }

    #attachAuthContextToReq = req => {
        if (this.#userDetail) {
            req[AUTH_CONTEXT.KEY_AUTH_CONTEXT] = this.#userDetail;
        }
    }

    #applyPreAuthorizationToUserDetail = () => {
        this.#userDetail.toRoles();
        this.#userDetail.toPermissions();
    }

    collectRequest(req) {
        this.#token = req.headers[AUTH_CONTEXT.AUTHORIZATION_HEADER];
        return this;
    }

    transfer(req) {
        if (this.#token) {
            const body = JwtValidator
                .builder()
                .applyToken(this.#token)
                .validate()
                .getPayload();
            this.#userDetail = new JwtAuthAdapter.USER_DETAIL_CLASS(body);
            this.#applyPreAuthorizationToUserDetail();
            this.#attachAuthContextToReq(req);
        }
    }
}
