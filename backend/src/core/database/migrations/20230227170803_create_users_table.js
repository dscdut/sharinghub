/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'users';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('full_name', [100]);
        table.boolean('gender').notNullable();
        table.date('birthday').notNullable();
        table.string('avatar').nullable();
        table.string('email').unique('email').notNullable();
        table.string('phone_number', [20]).unique('phone_number').notNullable();
        table.string('password');
        table.string('reset_token').defaultTo(null);
        table.dateTime('reset_token_expiration_date').defaultTo(null);
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
