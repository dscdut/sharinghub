import {
    LoginInterceptor,
    RegisterInterceptor,
    ForgotPasswordInterceptor,
    NewPasswordInterceptor
} from 'core/modules/auth';
import { Module } from 'packages/handler/Module';
import { AuthController } from './auth.controller';
import { resetToken } from '../../common/swagger/reset-token';

export const AuthResolver = Module.builder()
    .addPrefix({
        prefixPath: '/auth',
        tag: 'auth',
        module: 'AuthModule'
    })
    .register([
        {
            route: '/login',
            method: 'post',
            interceptors: [LoginInterceptor],
            body: 'LoginDto',
            controller: AuthController.login,
        },
        {
            route: '/register',
            method: 'post',
            interceptors: [RegisterInterceptor],
            body: 'RegisterDto',
            controller: AuthController.register
        },
        {
            route: '/forgot-password',
            method: 'post',
            interceptors: [ForgotPasswordInterceptor],
            body: 'ForgotPasswordDto',
            controller: AuthController.forgotPassword
        },
        {
            route: '/reset-password/:token',
            method: 'get',
            params: [resetToken],
            controller: AuthController.getResetPassword
        },
        {
            route: '/new-password',
            method: 'post',
            interceptors: [NewPasswordInterceptor],
            body: 'NewPasswordDto',
            controller: AuthController.newPassword
        },
    ]);
