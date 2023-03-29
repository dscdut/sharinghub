import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateCampaignDto', {
    name: SwaggerDocument.ApiProperty({ type: 'string' }),
    address: SwaggerDocument.ApiProperty({ type: 'string' }),
    specificAddress: SwaggerDocument.ApiProperty({
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
    startDate: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2023-01-01',
    }),
    endDate: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2023-12-01',
    }),
    registerLink: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
        example: 'https://docs.google.com/forms/register-for-campaign',
    }),
    donationRequirement: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
    }),
});

export const CreateCampaignDto = body => ({
    name: body.name,
    image: body.image,
    address: body.address,
    specific_address: body.specificAddress,
    coordinate: body.coordinate,
    description: body.description,
    start_date: body.startDate,
    end_date: body.endDate,
    register_link: body.registerLink,
    donation_requirement: body.donationRequirement,
});
