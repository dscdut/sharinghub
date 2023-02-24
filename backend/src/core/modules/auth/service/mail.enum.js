import { URL } from '../../../env';

export const MAIL = {
    REGISTER_SUCCESS: {
        subject: 'Welcome to SharingHub!',
        html: '<p>Welcome to SharingHub!</p>'
    },
    FORGOT_PASSWORD(token) {
        return {
            subject: 'Reset password request',
            html: `<p>Click this <a href="${URL}/reset-password/${token}">link</a> to reset your password<p>`
        };
    },
    PASSWORD_UPDATE: {
        subject: 'Password updated successfully',
        html: '<p>Your password has been updated successfully</p>'
    }
};
