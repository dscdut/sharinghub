import { getUserContext } from 'packages/authModel/module/user';

export class OrganizationOwnerGuard {
  canActive(req) {
    const { isOwningOrg } = getUserContext(req).payload;

    return isOwningOrg;
  }
}
