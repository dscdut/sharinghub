export class UserDetail {
    payload;

    roles;

    permissions;

    constructor(payload) {
        this.payload = payload;
    }

    toRoles() {
        this.roles = this.payload?.roles ?? [];
    }

    toPermissions() {
        this.permissions = this.payload?.permissions ?? [];
    }
}
