export class InvalidResolver extends Error {
    constructor(resolver) {
        super(`${resolver.name} is not contain resolve method to apply to app context`);
    }
}
