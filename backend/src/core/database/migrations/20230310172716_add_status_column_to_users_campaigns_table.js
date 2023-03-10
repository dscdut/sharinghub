/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.table('users_campaigns', table => {
    table.smallint('status').notNullable().defaultTo(1);
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    knex.schema.table('users_campaigns', table => {
        table.dropColumn('status');
    });
};
