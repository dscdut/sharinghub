/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'donation_records';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.integer('campaign_id').unsigned().notNullable();
        table
            .foreign('campaign_id')
            .references('id')
            .inTable('campaigns')
            .onDelete('CASCADE');
        table.integer('donor_id').unsigned().notNullable();
        table
            .foreign('donor_id')
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
        table.string('item_name').notNullable();
        table.integer('quantity').notNullable();
        table.integer('unit_id').notNullable();
        table
            .foreign('unit_id')
            .references('id')
            .inTable('units')
            .onDelete('CASCADE');
        table.smallint('status').notNullable().defaultTo(1);
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
