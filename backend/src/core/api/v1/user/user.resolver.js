import { Module } from 'packages/handler/Module';
import { UpdateUserInterceptor } from 'core/modules/user/interceptor';
import { UserController } from './user.controller';

export const UserResolver = Module.builder()
    .addPrefix({
        prefixPath: '/v1/users',
        tag: 'users',
        module: 'UserModule',
    })
    .register([
        {
            route: '/me',
            method: 'get',
            controller: UserController.findById,
            preAuthorization: true,
        },
        {
            route: '/me',
            method: 'put',
            interceptors: [UpdateUserInterceptor],
            body: 'UpdateUserDto',
            controller: UserController.updateOne,
            preAuthorization: true,
        },
        {
            route: '/my-voluntary-campaigns',
            method: 'get',
            controller: UserController.findVoluntaryCampaignsByUserId,
            preAuthorization: true,
        }, 
        {
            route: '/dont-have-org',
            method: 'get',
            controller: UserController.findAllUserNoOrg,
        }
    ]);