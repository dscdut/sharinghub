import connection from 'core/database';
import { logger } from 'core/utils';
import { camelCase, upperFirst } from 'lodash';

export class DataRepository {
    #table;

    #connection;

    constructor(tableName) {
        this.#table = tableName;
        this.#connection = connection;
        logger.info(`[${upperFirst(camelCase(this.#table))}Repository] is bundling`);
    }

    query() {
        return this.#connection(this.#table).clone();
    }

    /**
     * =======================================================================
     * ==============       Shortcut of model method           ===============
     * =======================================================================
     */

    insert(data = {}, trx = null, columns = 'id') {
        const queryBuilder = this.query().insert(data, columns);
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    update(id, data = {}, trx = null) {
        const queryBuilder = this.query().whereNull('deleted_at').where({ id }).update(data);
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    permanentlyDeleteMany(ids, trx = null) {
        const queryBuilder = this.query().whereIn('id', ids).delete();
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    softDeleteMany(ids, trx = null) {
        const queryBuilder = this.query().whereIn('id', ids).update({ deleted_at: this.#connection.fn.now() }, 'id');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    restore(ids, trx = null, columns = 'id') {
        const queryBuilder = this.query().whereIn('id', ids).update({ deleted_at: null }, columns);
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    findTrashed() {
        return this.query().whereNotNull('deleted_at');
    }

    removeNameConstraint() {
        return this.#connection.raw('ALTER TABLE campaigns DROP CONSTRAINT campaigns_name_unique');
    }
}
