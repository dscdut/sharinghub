/* eslint-disable no-unused-vars */
import { faker } from '@faker-js/faker/locale/vi';

/**
 * @param { import("knex").Knex } knex
 */

const tableName = 'campaigns';

const randomOrganizationId = async knex => {
    // get id column from users table
    const organizationIdArr = await knex.table('organizations').pluck('id');

    // Randomly pick an id from userIdArr
    const randomIndex = Math.floor(Math.random() * organizationIdArr.length);
    return organizationIdArr[randomIndex];
};

const point = (longitude, latitude) => `${longitude}, ${latitude}`;

// eslint-disable-next-line func-names
exports.seed = async function (knex) {
    // Deletes ALL existing entries
    await knex(tableName).del();

    await knex(tableName).insert([
        {
            name: 'Hỗ trợ trẻ em bị bệnh ung thư',
            province: 'Đà Nẵng',
            district: 'Hải Châu',
            ward: 'Hòa Minh',
            address:
                'Số 1, Đường 2, Khu phố 3, Phường Hòa Minh, Quận Hải Châu, Thành phố Đà Nẵng',
            start_date: '2023-03-01',
            end_date: '2023-07-30',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere voluptas veniam incidunt doloribus amet maxime sint! Optio soluta aliquam expedita dicta voluptatum perferendis a labore? Labore quo harum animi saepe!',
            donation_method: 1,
            organization_id: await randomOrganizationId(knex),
            // location: '10.823099, 106.629664',
            location: point(106.629664, 10.823099),
        },
        {
            name: 'Hỗ trợ trẻ em bị bỏ rơi',
            province: 'Huế',
            district: 'Phong Điền',
            ward: 'Phong Điền',
            address: 'Đường 3/2, Phường Phong Điền, Thành phố Huế, Thừa Thiên Huế',
            start_date: '2023-03-01',
            end_date: '2023-07-30',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere voluptas veniam incidunt doloribus amet maxime sint! Optio soluta aliquam expedita dicta voluptatum perferendis a labore? Labore quo harum animi saepe!',
            donation_method: 1,
            organization_id: await randomOrganizationId(knex),
            location: point(107.573, 16.463),
        },
    ]);
};
