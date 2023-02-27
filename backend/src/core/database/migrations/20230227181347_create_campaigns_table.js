/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'campaigns';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('name').unique().notNullable();
        table.string('province').notNullable();
        table.string('district').notNullable();
        table.string('ward').nullable();
        table.string('address').notNullable();
        table.datetime('start_date').notNullable();
        table.datetime('end_date').notNullable();
        table.string('register_link').nullable();
        table.smallint('donation_method').notNullable();
        table.integer('organization_id').unsigned().notNullable();
        table
            .foreign('organization_id')
            .references('id')
            .inTable('organizations')
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
