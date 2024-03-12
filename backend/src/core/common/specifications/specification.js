import { AndSpecification, OrSpecification } from './';

export class Specification {
    constructor() {
    }
    
    and(specification) {
        return new AndSpecification(this, specification);
    }

    or(specification) {
        return new OrSpecification(this, specification);
    }
}
