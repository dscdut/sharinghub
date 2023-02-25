import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('ForgotPasswordDto', {
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const ForgotPasswordDto = body => ({
    email: body.email,
});
