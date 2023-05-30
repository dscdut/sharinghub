/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'users_feedbacks';

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
        table.primary(['campaign_id', 'user_id']);
        table.smallint('organization_rate').notNullable().unsigned();
        table.text('organization_feedback').nullable();
        table.smallint('campaign_rate').notNullable().unsigned();
        table.text('campaign_feedback').nullable();
        table.timestamps(false, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
