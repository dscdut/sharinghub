/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('campaigns', table => {
    table.dropColumns('province', 'district', 'ward', 'donation_method', 'location');
    table.string('specificAddress').nullable();
    table.string('donation_requirement').nullable();
    table.json('coordinate').nullable();
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('campaigns', table => {
    table.string('province');
    table.string('district');
    table.string('ward');
    table.string('donation_method');
    table.dropColumn('specificAddress');
    table.dropColumn('donation_requirement');
    table.dropColumn('coordinate');
    table.string('location');
});
