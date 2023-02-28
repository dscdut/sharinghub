/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'organizations';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('name').unique().notNullable();
        table.string('address').notNullable();
        table.string('phone_number', [20]).unique().notNullable();
        table.text('description').nullable();
        table.string('avatar').nullable();
        table
            .integer('user_id')
            .unsigned()
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
