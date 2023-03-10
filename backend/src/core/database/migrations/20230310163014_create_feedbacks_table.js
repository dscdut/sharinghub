/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'feedbacks';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').primary();
        table.smallint('completed_rate').notNullable();
        table.smallint('location_rate').notNullable();
        table.text('traffic').nullable();
        table.text('weather').nullable();
        table.text('sanitization').nullable();
        table.text('residence').nullable();
        table.text('authority_cooperation').nullable();
        table.text('others').nullable();
        table.integer('campaign_id').unsigned().notNullable();
        table.foreign('campaign_id').references('campaigns.id').onDelete('CASCADE');
        table.timestamps(false, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.dropTable('feedbacks');
