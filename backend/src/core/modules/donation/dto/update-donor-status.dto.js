import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateDonorsStatusDto', {
    status: SwaggerDocument.ApiProperty({ type: 'int', example: 2 }),
});

export const UpdateDonorsStatusDto = body => ({
    status: body.status
});
