/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.table('campaigns', table => {
    return Promise.all([
        table.string('ward').notNullable(),
        table.string('district').notNullable(),
        table.string('city').notNullable(),
    ]);
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => {
    return Promise.all([
        knex.schema.table('campaigns', table => {
            table.dropColumns('ward', 'district', 'city');
        })
    ]);
};
