// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'roles';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('name');
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);
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
