export class Optional {
    #instance;

    constructor(instance) {
        this.#instance = instance;
    }

    static of(instance) {
        return new Optional(instance);
    }

    throwIfPresent(exception) {
        if ((Array.isArray(this.#instance) && this.#instance[0]) || (!Array.isArray(this.#instance) && this.#instance)) {
            throw exception;
        }
        return this;
    }

    throwIfNotPresent(exception) {
        if ((Array.isArray(this.#instance) && !this.#instance[0])
      || (!Array.isArray(this.#instance) && !this.#instance)) {
            throw exception;
        }
        return this;
    }

    throwIfNullable(exception) {
        if (this.#instance === null) {
            throw exception;
        }
        return this;
    }

    throwIfExist(exception) {
        if ((Array.isArray(this.#instance) && this.#instance[0]) || this.#instance) {
            throw exception;
        }
        return this;
    }

    isPresent() {
        if (Array.isArray(this.#instance)) {
            return Boolean(this.#instance[0]);
        }
        return Boolean(this.#instance);
    }

    get() {
        if (!this.#instance) throw new Error('Should call throwIfNullable first');
        return this.#instance;
    }
}
