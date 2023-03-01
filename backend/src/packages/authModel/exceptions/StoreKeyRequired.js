export class StoreKeyRequired extends Error {
    constructor(rule, ruleName) {
        super(`${ruleName} require storeKey with policy or dataPreload `
         + `method ${rule.methodName} in service ${rule.service}`);
    }
}
