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
    table.int('quantity').alter();
    table.integer('donor_id').unsigned().notNullable();
    table
        .foreign('donor_id')
        .references('id')
        .inTable('users')
        .onDelete('CASCADE');
});
