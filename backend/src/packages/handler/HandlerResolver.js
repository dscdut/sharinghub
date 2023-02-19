import express from 'express';

export class HandlerResolver {
    #globalRouter = express.Router();

    /**
     * @type {import('../swagger/core/core')} swagger instance
     */
    #swagger;

    static builder() {
        return new HandlerResolver();
    }

    /**
     *
     * @param {[import('./Module').Module]} modules
     */
    addModule(modules) {
        modules.forEach(module => {
            module.build(this.#globalRouter);
            module.buildSwagger(this.#swagger);
        });
        return this;
    }

    addSwaggerBuilder(swagger) {
        this.#swagger = swagger;
        return this;
    }

    /**
     *
     * @returns {import('express').Router}
     */
    resolve() {
        return this.#globalRouter;
    }
}
