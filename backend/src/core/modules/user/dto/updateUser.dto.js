import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateUserDto', {
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const UpdateUserDto = body => ({
    email: body.email,
    full_name: body.fullName,
});
