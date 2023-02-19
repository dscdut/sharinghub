import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateUserDto', {
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
    password: SwaggerDocument.ApiProperty({ type: 'string' }),
    confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const CreateUserDto = body => ({
    email: body.email,
    full_name: body.fullName,
    password: body.password,
    confirm_password: body.confirmPassword,
});
