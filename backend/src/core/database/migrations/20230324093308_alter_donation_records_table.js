/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('donation_records', table => {
    table.dropColumns('unit_id');
    table.string('quantity').alter();
});
/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('donation_records', table => {
    table.integer('quantity').alter();
    table.integer('unit_id').notNullable();
    table
        .foreign('unit_id')
        .references('id')
        .inTable('units')
        .onDelete('CASCADE');
});
