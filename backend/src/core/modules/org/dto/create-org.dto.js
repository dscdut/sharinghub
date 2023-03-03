import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateOrgDto', {
    name: SwaggerDocument.ApiProperty({ type: 'string' }),
    address: SwaggerDocument.ApiProperty({ type: 'string' }),
    phoneNumber: SwaggerDocument.ApiProperty({ type: 'string' }),
    description: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const CreateOrgDto = body => ({
    name: body.name,
    address: body.address,
    phone_number: body.phoneNumber,
    description: body.description,
});
