/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'campaigns';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('name').notNullable();
        table.string('province').notNullable();
        table.string('district').notNullable();
        table.string('ward').notNullable();
        table.string('address').notNullable();
        table.point('location');
        table.datetime('start_date').notNullable();
        table.datetime('end_date').notNullable();
        table.text('description').notNullable();
        table.string('register_link').nullable();
        table.smallint('donation_method').defaultTo(1);
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
