export class MethodRequired extends Error {
    constructor(className, method) {
        super(`class ${className} should contain method ${method}`);
    }
}
