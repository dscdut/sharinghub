import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateUserStatusDto', {
    status: SwaggerDocument.ApiProperty({ type: 'int', example: 1 }),
});

export const UpdateUserStatusDto = body => ({
    status: body.status,
});
