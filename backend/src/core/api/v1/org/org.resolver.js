import { Module } from 'packages/handler/Module';
import { CreateOrgInterceptor } from 'core/modules/org/';
import { OrgController } from './org.controller';
import { orgId } from '../../../common/swagger/org-id';
import { MediaInterceptor } from '../../../modules/document/interceptor/media.interceptor';
import { uploadMediaSwagger } from 'core/common/swagger';

export const OrgResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1/organizations',
        tag: 'org',
        module: 'OrgModule'
    })
    .register([
        {
            route: '/',
            method: 'post',
            interceptors: [new MediaInterceptor(), CreateOrgInterceptor],
            params: [uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            body: 'CreateOrgDto',
            controller: OrgController.createOrg,
            preAuthorization: true,
        },
        {
            route: '/my-organizations',
            method: 'get',
            controller: OrgController.getMyOrgs,
            preAuthorization: true,
        },
        {
            route: '/:id',
            method: 'get',
            params: [orgId],
            controller: OrgController.getOrgById,
            preAuthorization: true,
        },
        {
            route: '/:id',
            method: 'put',
            interceptors: [new MediaInterceptor(), CreateOrgInterceptor],
            params: [orgId, uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            body: 'CreateOrgDto',
            controller: OrgController.putEditOrg,
            preAuthorization: true,
        }, 
        {
            route: '/:id',
            params: [orgId],
            method: 'delete',
            controller: OrgController.deleteOrg,
            preAuthorization: true,
        }

    ]);