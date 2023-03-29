import { SwaggerDocument } from '../../../packages/swagger';

export const LatitudeQuery = SwaggerDocument.ApiParams(
    {
        name: 'lat',
        paramsIn: 'query',
        type: 'string',
        required: false,
        description: "Latitude to look up campaigns in the area",
    }
);