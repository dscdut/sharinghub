import nodemailer from 'nodemailer';
import sendgridTransport from 'nodemailer-sendgrid-transport';
import { logger } from '../../../../packages/logger';
import { EMAIL, SENDGRID_API_KEY } from '../../../env';

class Nodemailer {
    api_key = SENDGRID_API_KEY;

    email = EMAIL;

    constructor() {
        logger.info(`[${Nodemailer.name}] is bundling`);
    }

    createTransport() {
        return nodemailer.createTransport(
            sendgridTransport({
                auth: {
                    api_key: this.api_key
                }
            })
        );
    }

    sendMail(email, { subject, html }) {
        return this.createTransport().sendMail({
            to: email,
            from: this.email,
            subject,
            html
        });
    }
}

export const NodemailerService = new Nodemailer();
