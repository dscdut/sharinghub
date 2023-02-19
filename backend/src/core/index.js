import 'dotenv/config';
import express from 'express';
import { SecurityFilter } from 'packages/authModel/core/security/SecurityFilter';
import { ApiDocument } from 'core/config/swagger.config';
import { HttpExceptionFilter } from '../packages/httpException/HttpExceptionFilter';
import { InvalidUrlFilter } from '../packages/handler/filter/InvalidUrlFilter';
import { AppBundle } from './config';
import { ModuleResolver } from './api';

const app = express();

(async () => {
    await AppBundle.builder()
        .applyAppContext(app)
        .init()
        .applyGlobalFilters([new SecurityFilter()])
        .applyResolver(ModuleResolver)
        .applySwagger(ApiDocument)
        .applyGlobalFilters([new HttpExceptionFilter(), new InvalidUrlFilter()])
        .run();
})();

export default app;
