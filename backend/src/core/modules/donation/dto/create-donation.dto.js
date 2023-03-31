import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateDonationDto', {
    itemName: SwaggerDocument.ApiProperty({ type: 'string' }),
    quantity: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const CreateDonationDto = body => ({
    item_name: body.itemName,
    quantity: body.quantity,
});
