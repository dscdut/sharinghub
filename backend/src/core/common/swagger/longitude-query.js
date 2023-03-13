import { SwaggerDocument } from '../../../packages/swagger';

export const LongitudeQuery = SwaggerDocument.ApiParams(
    {
        name: 'lng',
        paramsIn: 'query',
        type: 'string',
        required: false,
        description: "Longitude to look up campaigns in the area",
    }
);