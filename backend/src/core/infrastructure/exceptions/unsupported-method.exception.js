export class UnsupportedMethodException extends Error {
    constructor(collectionName, method) {
        super(`Model ${collectionName} is not support ${method} method. Please verify model ${collectionName}`);
    }
}
