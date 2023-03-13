import { SwaggerDocument } from '../../../packages/swagger';

export const NameQuery = SwaggerDocument.ApiParams({
    name: 'name',
    paramsIn: 'query',
    type: 'string',
    required: false,
    description: "Campaign's name or organization's name",
});