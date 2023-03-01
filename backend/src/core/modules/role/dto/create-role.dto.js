import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CreateRoleDto', {
    name: SwaggerDocument.ApiProperty({ type: 'string' }),
    color: SwaggerDocument.ApiProperty({ type: 'string' }),
    serverId: SwaggerDocument.ApiProperty({ type: 'string' }),
    permissions: SwaggerDocument.ApiProperty({ type: 'array', model: 'string' }),
});

export const CreateRoleDto = body => ({
    name: body.name,
    color: body.color,
    server: body.serverId,
    permissions: body.permissions,
});
