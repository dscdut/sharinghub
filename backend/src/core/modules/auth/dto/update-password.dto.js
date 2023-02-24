import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('NewPasswordDto',
    {
        password: SwaggerDocument.ApiProperty({ type: 'string' }),
        confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
        resetToken: SwaggerDocument.ApiProperty({ type: 'string' }),
    });

export const UpdatePasswordDto = body => ({
    password: body.password,
    confirm_password: body.confirmPassword,
    reset_token: body.resetToken,
});
