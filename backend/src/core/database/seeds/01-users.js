import { faker } from '@faker-js/faker/locale/vi';

/**
 * @param { import("knex").Knex } knex
 */
const tableName = 'users';
// 123456
const DEFAULT_PASSWORD = '$2b$10$4WxWKojNnKfDAicVsveh7.ogkWOBMV1cvRUSPCXwxA05NRX18F0QW';

function randomBool() {
    return Math.random() < 0.5;
}

exports.seed = async knex => {
    // Deletes ALL existing entries
    await knex(tableName).del();

    let data = [];
    for (let i = 0; i < 20; i++) {
        data.push({
            full_name: faker.name.fullName(),
            gender: randomBool(),
            birthday: faker.date.birthdate(),
            email: faker.internet.email(),
            phone_number: faker.phone.number(),
            address: faker.address.streetAddress(),
            password: DEFAULT_PASSWORD,
        });
    }

    await knex(tableName).insert(data);
};
