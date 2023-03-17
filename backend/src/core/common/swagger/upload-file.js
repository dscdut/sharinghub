import { SwaggerDocument } from '../../../packages/swagger';

export const uploadMediaSwagger = SwaggerDocument.ApiParams({
    name: 'image',
    paramsIn: 'formData',
    required: false,
    type: 'file',
    description: 'Image file to upload',
});
