export const JwtPayload = user => (
    {
        id: user.id,
        roles: user.roles
    }
);
