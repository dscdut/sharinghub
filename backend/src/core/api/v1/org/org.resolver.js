import { Module } from 'packages/handler/Module';
import { CreateOrgInterceptor } from 'core/modules/org/';
import { OrgController } from './org.controller';
import { orgId } from '../../../common/swagger/org-id';

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
            interceptors: [CreateOrgInterceptor],
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
            interceptors: [CreateOrgInterceptor],
            params: [orgId],
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
