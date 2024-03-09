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

exports.seed = async function (knex) {
    // Deletes ALL existing entries
    await knex(tableName).del();

    await knex(tableName).insert([
        {
            name: 'Hỗ trợ trẻ em bị bệnh ung thư',
            address: 'Phường Hòa Minh, Quận Hải Châu, Thành phố Đà Nẵng',
            specific_address:
                'Số 1, Đường 2, Khu phố 3, Phường Hòa Minh, Quận Hải Châu, Thành phố Đà Nẵng',
            start_date: '2023-03-01',
            end_date: '2023-07-30',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere voluptas veniam incidunt doloribus amet maxime sint! Optio soluta aliquam expedita dicta voluptatum perferendis a labore? Labore quo harum animi saepe!',
            organization_id: await randomOrganizationId(knex),
            coordinate: {
                lat: 16.0678,
                lng: 108.2208,
            },
            ward: 'Hòa Minh',
            district: 'Hải Châu',
            city: 'Đà Nẵng',
        },
        {
            name: 'Hỗ trợ trẻ em bị bỏ rơi',
            address: 'Phường Phong Điền, Thành phố Huế, Thừa Thiên Huế',
            specific_address:
                'Đường 3/2, Phường Phong Điền, Thành phố Huế, Thừa Thiên Huế',
            start_date: '2023-03-01',
            end_date: '2023-07-30',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere voluptas veniam incidunt doloribus amet maxime sint! Optio soluta aliquam expedita dicta voluptatum perferendis a labore? Labore quo harum animi saepe!',
            organization_id: await randomOrganizationId(knex),
            coordinate: {
                lat: 16.4678,
                lng: 107.6208,
            },
            ward: 'Phong Điền',
            district: 'Thừa Thiên Huế',
            city: 'Huế',
        },
    ]);
};