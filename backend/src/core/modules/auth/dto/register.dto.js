import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('RegisterDto', {
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
    password: SwaggerDocument.ApiProperty({ type: 'string' }),
    confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
    birthday: SwaggerDocument.ApiProperty({ type: 'string', format: 'date', example: '2000-01-01' }),
    gender: SwaggerDocument.ApiProperty({ type: 'boolean', example: true }),
    phoneNumber: SwaggerDocument.ApiProperty({ type: 'string', example: '0123456789' }),
    address: SwaggerDocument.ApiProperty({ type: 'string', example: '123 Nguyen Luong Bang' })
});

export const RegisterDto = body => ({
    email: body.email,
    full_name: body.fullName,
    password: body.password,
    confirm_password: body.confirmPassword,
    birthday: body.birthday,
    gender: body.gender,
    phone_number: body.phoneNumber,
    address: body.address
});
