/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'donation_images';

exports.up = async knex => {
    await knex.schema.dropTableIfExists(tableName);

    await knex.schema.createTable(tableName, table => {
        table.integer('donation_id').unsigned().notNullable();
        table
            .foreign('donation_id')
            .references('id')
            .inTable('donation_records')
            .onDelete('CASCADE');
        table.string('image').notNullable();
        table.primary(['donation_id', 'image']);
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);
    });
};

/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
