/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('users_roles')
    .del()
    .then(() => knex('users_roles').insert([
        {
            user_id: 1,
            role_id: 1,
        },
        {
            user_id: 1,
            role_id: 2,
        },
        {
            user_id: 1,
            role_id: 3,
        },
        {
            user_id: 2,
            role_id: 2,
        },
        {
            user_id: 2,
            role_id: 3,
        },
        {
            user_id: 3,
            role_id: 3,
        },
    ]));
