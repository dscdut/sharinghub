/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => {
    return knex.schema.table('campaigns', function (table) {
        table.renameColumn('specificAddress', 'specific_address');
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    return knex.schema.table('campaigns', function (table) {
        table.renameColumn('specific_address', 'specificAddress');
    });
};
