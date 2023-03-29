/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => {
    return knex.schema.table('organizations', table => {
        table.string('org_link');
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    return knex.schema.table('organizations', table => {
        table.dropColumn('org_link');
    });
};
