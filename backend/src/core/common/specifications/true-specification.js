import { Specification } from './';

export class TrueSpecification extends Specification {
    constructor() {
        super();
    }

    toSql() {
        return [`true = ?`, true];
    }
}
