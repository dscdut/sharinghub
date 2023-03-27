import { MediaResolver } from 'core/api/v1/media';
import { UserResolver } from 'core/api/v1/user/user.resolver';
import { ApiDocument } from 'core/config/swagger.config';
import { HandlerResolver } from '../../packages/handler/HandlerResolver';
import { AuthResolver } from './v1/auth/auth.resolver';
import { OrgResolver } from './v1/org/org.resolver';
import { CampaignResolver } from './v1/campaign';
import { VolunteerResolver } from './v1/campaign/volunteer.resolver';

export const ModuleResolver = HandlerResolver.builder()
    .addSwaggerBuilder(ApiDocument)
    .addModule([
        AuthResolver,
        UserResolver,
        MediaResolver,
        OrgResolver,
        CampaignResolver,
        VolunteerResolver,
    ]);
