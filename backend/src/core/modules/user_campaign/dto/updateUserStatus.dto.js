import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateUserStatusDto', {
    status: SwaggerDocument.ApiProperty({ type: 'number', required: true, example: 1 }),
});

export const UpdateUserStatusDto = body => ({
    status: body.status,
});
