export class ArgumentRequired extends Error {
    constructor(arg, context) {
        super(`${arg} is required in ${context}`);
    }
}
