import { faker } from '@faker-js/faker/locale/vi';

/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'campaigns';

const randomOrganizationId = async knex => {
    //get id column from users table
    const organizationIdArr = await knex.table('organizations').pluck('id');

    // Randomly pick an id from userIdArr
    const randomIndex = Math.floor(Math.random() * organizationIdArr.length);
    return organizationIdArr[randomIndex];
};

const randomCity = () => {
    let city = ['Đà nẵng', 'Huế', 'Quảng Bình', 'Quảng Trị', 'Quảng Nam', 'Quảng Ngãi'];

    return city[Math.floor(Math.random() * city.length)];
};

exports.seed = async function (knex) {
    // Deletes ALL existing entries
    await knex(tableName).del();

    let data = [];
    for (let i = 0; i < 10; i++) {
        const province = randomCity();
        const address = `${faker.address.streetAddress(false)}, ${province}`;

        data.push({
            name: faker.company.name(),
            province,
            address,
            start_date: faker.date.between('2023-01-01', '2023-12-31'),
            end_date: faker.date.between('2023-01-01', '2023-12-31'),
            description: faker.lorem.paragraph(),
            donation_method: 1,
            // eslint-disable-next-line no-await-in-loop
            organization_id: await randomOrganizationId(knex),
        });
    }

    await knex(tableName).insert(data);
};
