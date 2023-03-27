/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => {
    return knex.schema.table('users_campaigns', table => {
        table.dropColumn('role');
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    return knex.schema.table('users_campaigns', table => {
        table.string('role').notNullable();
    });
};
