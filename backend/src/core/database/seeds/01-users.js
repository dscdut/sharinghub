/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('users')
    .del()
    .then(() => knex('users').insert([
        {
            full_name: 'Super Admin',
            email: 'spadmin@gmail.com',
        },
        {
            full_name: 'Admin',
            email: 'admin@gmail.com',
        },
        {
            full_name: 'User',
            email: 'user@gmail.com',
        },
    ]));
