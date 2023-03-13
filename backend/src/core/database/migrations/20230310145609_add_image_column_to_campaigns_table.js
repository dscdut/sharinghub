/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('campaigns', table => {
    table.string('image').nullable();
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('campaigns', table => {
    table.dropColumn('image');
});
