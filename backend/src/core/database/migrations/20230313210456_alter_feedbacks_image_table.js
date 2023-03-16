/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('feedback_images', table => {
    table.dropForeign(['feedback_id']);
    table
    .foreign('feedback_id')
    .references('id')
    .inTable('feedbacks')
    .onDelete('CASCADE');
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('feedback_images', table => {
    table.dropForeign(['feedback_id']);
    table
    .foreign('feedback_id')
    .references('id')
    .inTable('feedbacks')
    .onDelete('CASCADE');
});
