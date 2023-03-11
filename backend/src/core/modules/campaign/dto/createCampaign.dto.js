import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateCampaignDto', {
    name: SwaggerDocument.ApiProperty({ type: 'string' }),
    province: SwaggerDocument.ApiProperty({ type: 'string' }),
    district: SwaggerDocument.ApiProperty({ type: 'string' }),
    ward: SwaggerDocument.ApiProperty({ type: 'string' }),
    address: SwaggerDocument.ApiProperty({ type: 'string' }),
    longitude: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
    }),
    latitude: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
    }),
    description: SwaggerDocument.ApiProperty({ type: 'string' }),
    start_date: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2003-01-01',
    }),
    end_date: SwaggerDocument.ApiProperty({
        type: 'string',
        format: 'date',
        example: '2003-12-01',
    }),
    register_link: SwaggerDocument.ApiProperty({
        type: 'string',
        required: false,
        example: 'https://docs.google.com/forms/register-for-campaign',
    }),
    donation_method: SwaggerDocument.ApiProperty({
        type: 'number',
        required: false,
    }),
    organization_id: SwaggerDocument.ApiProperty({ type: 'string' }),
});

const point = (longitude, latitude) => {
    if (!longitude || !latitude) return null;

    return `${longitude}, ${latitude}`;
};

export const CreateCampaignDto = body => ({
    name: body.name,
    province: body.province,
    district: body.district,
    ward: body.ward,
    address: body.address,
    location: point(body.longitude, body.latitude),
    description: body.description,
    start_date: body.start_date,
    end_date: body.end_date,
    register_link: body.register_link,
    donation_method: body.donation_method,
    organization_id: body.organization_id,
});
