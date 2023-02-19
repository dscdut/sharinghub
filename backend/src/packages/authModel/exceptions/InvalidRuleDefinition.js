export class InvalidRuleDefinition extends Error {
    constructor(ruleExecutionCollection) {
        super(`${ruleExecutionCollection} an not transform into rule execution context`);
    }
}
