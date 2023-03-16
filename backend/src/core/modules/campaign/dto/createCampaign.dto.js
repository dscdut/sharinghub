import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateCampaignDto', {
    name: SwaggerDocument.ApiProperty({ type: 'string' }),
    image: SwaggerDocument.ApiProperty({ type: 'string', required: false }),
    address: SwaggerDocument.ApiProperty({ type: 'string' }),
    specific_address: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
    }),
    coordinate: SwaggerDocument.ApiProperty({
        type: 'object',
        required: false,
        properties: {
            lat: SwaggerDocument.ApiProperty({ type: 'number' }),
            lng: SwaggerDocument.ApiProperty({ type: 'number' }),
        },
        example: {
            lat: 10.123456,
            lng: 10.123456,
        },
    }),
    description: SwaggerDocument.ApiProperty({ type: 'string' }),
    start_date: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2023-01-01',
    }),
    end_date: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2023-12-01',
    }),
    register_link: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
        example: 'https://docs.google.com/forms/register-for-campaign',
    }),
    donation_requirement: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
    }),
});

export const CreateCampaignDto = body => ({
    name: body.name,
    image: body.image,
    address: body.address,
    specific_address: body.specific_address,
    coordinate: body.coordinate,
    description: body.description,
    start_date: body.start_date,
    end_date: body.end_date,
    register_link: body.register_link,
    donation_requirement: body.donation_requirement,
});
