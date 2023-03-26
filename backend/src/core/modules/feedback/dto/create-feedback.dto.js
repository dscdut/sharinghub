import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateFeedbackDto', {
    locationRate: SwaggerDocument.ApiProperty({ type: 'int' }),
    traffic: SwaggerDocument.ApiProperty({ type: 'string' }),
    weather: SwaggerDocument.ApiProperty({ type: 'string' }),
    sanitization: SwaggerDocument.ApiProperty({ type: 'string' }),
    residence: SwaggerDocument.ApiProperty({ type: 'string' }),
    authorityCooperation: SwaggerDocument.ApiProperty({ type: 'string' }),
    others: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const CreateFeedbackDto = body => ({
    location_rate: body.locationRate,
    traffic: body.traffic,
    weather: body.weather,
    sanitization: body.sanitization,
    residence: body.residence,
    authority_cooperation: body.authorityCooperation,
    others: body.others,
});