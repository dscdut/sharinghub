import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateUserDto', {
    full_name: SwaggerDocument.ApiProperty({ type: 'string', required: true }),
    email: SwaggerDocument.ApiProperty({ type: 'string', required: true }),
    birthday: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
    avatar: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
    gender: SwaggerDocument.ApiProperty({ type: 'boolean', required: false }),
    phone_number: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
    address: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
    workplace: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
});

export const UpdateUserDto = body => ({
    email: body.email,
    full_name: body.full_name,
    birthday: body.birthday,
    avatar: body.avatar,
    gender: body.gender,
    phone_number: body.phone_number,
    address: body.address,
    workplace: body.workplace,
});
