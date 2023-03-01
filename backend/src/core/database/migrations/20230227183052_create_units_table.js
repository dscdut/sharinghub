/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'units';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('name').unique().notNullable();
        table.dateTime('deleted_at').defaultTo(null);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
