import pick from 'lodash/pick';

class Service {
    getUserInfo(user) {
        return pick(user, ['id', 'email', 'roles', 'fullName']);
    }
}

export const UserDataService = new Service();
