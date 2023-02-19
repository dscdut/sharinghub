// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'users_roles';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.integer('user_id').unsigned().references('id').inTable('users')
            .onDelete('CASCADE')
            .notNullable();
        table.integer('role_id').unsigned().references('id').inTable('roles')
            .notNullable();

        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);

        table.primary(['user_id', 'role_id']);
    });

    await knex.raw(`
    CREATE TRIGGER update_timestamp
    BEFORE UPDATE
    ON ${tableName}
    FOR EACH ROW
    EXECUTE PROCEDURE update_timestamp();
  `);
};

exports.down = knex => knex.schema.dropTable(tableName);
