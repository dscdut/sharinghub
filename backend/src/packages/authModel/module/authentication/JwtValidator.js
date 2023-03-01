import { JwtService } from 'core/utils';
import { UnAuthorizedException } from '../../../httpException';
import { AUTH_CONTEXT } from '../../common/enum/authContext';

export class JwtValidator {
    #accessToken;

    #payload;

    static builder() {
        return new JwtValidator();
    }

    applyToken(accessToken) {
        if (accessToken) {
            this.#accessToken = accessToken.startsWith(AUTH_CONTEXT.PREFIX_HEADER)
                ? accessToken.slice(7)
                : accessToken;
        }
        return this;
    }

    validate() {
        if (this.#accessToken) {
            try {
                this.#payload = JwtService.verify(this.#accessToken);
            } catch (e) {
                throw new UnAuthorizedException();
            }
        }
        return this;
    }

    getPayload() {
        return this.#payload;
    }
}
