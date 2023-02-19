export class InvalidInstance extends Error {
    constructor(preInstance, validateInstance) {
        super(`Instance ${preInstance.name} is not a subtype of ${validateInstance.name}`);
    }
}
