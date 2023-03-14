/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => {
    return knex.schema.table('users', table => {
        table.string('workplace');
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    return knex.schema.table('users', table => {
        table.dropColumn('workplace');
    });
};
