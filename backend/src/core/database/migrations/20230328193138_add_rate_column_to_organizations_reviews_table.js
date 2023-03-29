/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('organizations_reviews', table => {
    table.smallint('rate').notNullable();
    table.string('content').nullable().alter();
});
/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('organizations_reviews', table => {
    table.dropColumn('rate');
    table.string('content').notNullable().alter();
});
