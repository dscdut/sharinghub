/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'users_campaigns';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.integer('campaign_id').unsigned().notNullable();
        table
            .foreign('campaign_id')
            .references('id')
            .inTable('campaigns')
            .onDelete('CASCADE');
        table.integer('user_id').unsigned().notNullable();
        table
            .foreign('user_id')
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
        table.smallint('role').notNullable();
        table.primary(['campaign_id', 'user_id']);
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
