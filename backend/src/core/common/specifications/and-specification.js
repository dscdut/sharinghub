import { Specification } from './';

export class AndSpecification extends Specification {
    #leftSpecification;
    #rightSpecification;
    constructor(leftSpecification, rightSpecification) {
        super();
        this.#leftSpecification = leftSpecification;
        this.#rightSpecification = rightSpecification;
    }

    toSql() {
        const [leftSql, leftValues] = this.#leftSpecification.toSql();
        const [rightSql, rightValues] = this.#rightSpecification.toSql();
        return [`${leftSql} AND ${rightSql}`, [leftValues, rightValues].flat()];
    }
}