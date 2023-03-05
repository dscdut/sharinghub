/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'units';

// eslint-disable-next-line func-names
exports.seed = async function (knex) {
    // Deletes ALL existing entries
    await knex(tableName).del();

    await knex(tableName).insert([
        { name: 'kg' },
        { name: 'g' },
        { name: 'l' },
        { name: 'bộ' },
        { name: 'cái' },
        { name: 'cuốn' },
    ]);
};
