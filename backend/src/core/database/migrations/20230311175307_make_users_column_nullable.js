/**
 * @param { import("knex").Knex } knex
 */
exports.up = knex => knex.schema.alterTable('users', table => {
    table.boolean('gender').nullable().alter();
    table.date('birthday').nullable().alter();
    table.string('phone_number', [20]).nullable().alter();
    table.string('address').nullable().alter();  
});

/**
 * @param { import("knex").Knex } knex
 */
exports.down = knex => knex.schema.alterTable('users', table => {
    table.boolean('gender').nullable().alter();
    table.date('birthday').nullable().alter();
    table.string('phone_number', [20]).nullable().alter();
    table.string('address').nullable().alter();    
});
