import nodemailer from 'nodemailer';
import sendgridTransport from 'nodemailer-sendgrid-transport';
import { logger } from '../../../../packages/logger';
import { EMAIL, SENGRID_API_KEY } from '../../../env';

class Nodemailer {
    api_key = SENGRID_API_KEY;

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

    sendMail(email, mailType) {
        return this.createTransport().sendMail({
            to: email,
            from: this.email,
            subject: mailType.subject,
            html: mailType.html
        });
    }
}

export const NodemailerService = new Nodemailer();
