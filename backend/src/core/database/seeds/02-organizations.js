import { faker } from '@faker-js/faker/locale/vi';

/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'organizations';

const randomUserId = async knex => {
    // get id column from users table
    const userIdArr = await knex.table('users').pluck('id');

    // Randomly pick an id from userIdArr
    const randomIndex = Math.floor(Math.random() * userIdArr.length);
    return userIdArr[randomIndex];
};

exports.seed = async knex => {
    // Deletes ALL existing entries
    await knex(tableName).del();

    const data = [];
    for (let i = 0; i < 10; i += 1) {
        data.push({
            name: faker.company.name(),
            address: faker.address.streetAddress(),
            description: faker.lorem.paragraph(),
            phone_number: faker.phone.number('09########'),
            // eslint-disable-next-line no-await-in-loop
            user_id: await randomUserId(knex),
        });
    }

    await knex(tableName).insert(data);
};
