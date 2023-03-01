import { SwaggerDocument } from '../../../packages/swagger';

export const uploadMediaSwagger = SwaggerDocument.ApiParams({
    name: 'image',
    paramsIn: 'formData',
    require: true,
    type: 'file',
    description: 'Image file to upload',
});
