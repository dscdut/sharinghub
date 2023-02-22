import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('NewPasswordDto',
    {
        password: SwaggerDocument.ApiProperty({ type: 'string' }),
        confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
        resetToken: SwaggerDocument.ApiProperty({ type: 'string' }),
        // ID: SwaggerDocument.ApiProperty({ type: 'integer' })
    });

export const NewPasswordDto = body => ({
    password: body.password,
    confirm_password: body.confirmPassword,
    reset_token: body.resetToken,
    // id: body.ID
});
