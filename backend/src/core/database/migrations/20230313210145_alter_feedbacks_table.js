/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('feedbacks', table => {
    table.dropColumns('completed_rate');
});
/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('feedbacks', table => {
    table.smallint('completed_rate').notNullable();
});
