/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'feedback_images';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.integer('feedback_id').unsigned().notNullable();
        table
            .foreign('feedback_id')
            .references('id')
            .inTable('donation_records')
            .onDelete('CASCADE');
        table.string('image').notNullable();
        table.primary(['feedback_id', 'image']);
        table.timestamps(false, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
