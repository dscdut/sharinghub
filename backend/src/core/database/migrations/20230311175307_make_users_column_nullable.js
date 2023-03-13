/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async knex => {
    await knex.schema.alterTable('users', table => {
        table.boolean('gender').nullable().alter();
        table.date('birthday').nullable().alter();
        table.string('phone_number', [20]).nullable().alter();
        table.string('address').nullable().alter();    
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = async knex => {
    await knex.schema.alterTable('users', table => {
        table.boolean('gender').nullable().alter();
        table.date('birthday').nullable().alter();
        table.string('phone_number', [20]).nullable().alter();
        table.string('address').nullable().alter();    
    });
};
