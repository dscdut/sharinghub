/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'organizations_reviews';

exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.integer('organization_id').unsigned().notNullable();
        table.integer('user_id').unsigned().notNullable();
        table.text('content').notNullable();
        table
            .foreign('organization_id')
            .references('id')
            .inTable('organizations')
            .onDelete('CASCADE');
        table
            .foreign('user_id')
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
        table.primary(['organization_id', 'user_id']);
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
