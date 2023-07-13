import 'dart:math';

import 'package:convert_vietnamese/convert_vietnamese.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/user.model.dart';

abstract class UserMock {
  static final List<String> _name = [
    'Hiếu Học',
    'Minh Giang',
    'Chí Thành',
    'Tức Phong',
    'Tông Nguyên',
    'Tùng Lâm',
    'Hòa Thái',
    'Công Lập',
    'Kim Hoàng',
    'Huy Hoàng',
    'Khánh Hoàn',
    'Gia Hùng',
    'Đăng Quang',
    'Lương Quyền',
    'Duy Khang',
    'Trọng Dũng',
    'Hán Lâm',
    'Thành Hòa',
    'Minh Hòa',
    'Quốc Trung',
    'Kim Mai',
    'Thu Nguyệt',
    'Ngọc Tiệp',
    'Diệu Hằng',
    'Vân Thúy',
    'Thanh Trúc',
    'Mỹ Nga',
    'Diễm My',
    'Hà Liên',
    'Kiều Loan',
    'Phương Mai',
    'Vân Trinh',
    'Vân Nhi',
    'Hoài Trang',
    'Tài Trang',
    'Thục Trinh',
    'Thu Ngân',
    'Quỳnh Giang',
    'Bạch Tuyết',
    'Ánh Mai',
    'Kim Hòa',
    'Kim Anh',
    'Quỳnh Hà',
    'Hoa Thiên',
    'Phương Chi',
    'Thu Ngọc',
    'Quế Phương',
    'Hiếu Khanh',
    'Thanh Lâm',
    'Xuân Thảo',
    'Linh Hà',
    'Thanh Nhàn',
    'Gia Linh',
    'Minh Khuê',
    'Thúy My',
    'Nhã Thanh',
    'Phương Giang',
    'Hiếu Hạnh',
    'Thục Toan',
    'Quỳnh Dung',
    'Hướng Dương',
    'Lam Phương',
    'Thanh Liêm',
    'Mạnh Nghiêm',
    'Hoàng Phát',
    'Thái Bình',
    'Hồ Bắc',
    'Thanh Trung',
    'Tức Tuấn',
    'Minh Vũ',
    'Tình Cường',
    'Thái Tức',
    'Hữu Bào',
    'Duy An',
    'Hoài Vỹ',
    'Toàn Thắng',
    'Tất Bình',
    'Thanh Minh',
    'Minh Khiếu',
    'Bích Nhã',
  ];

  static List<UserModel> getRandomUser(int count) {
    _name.shuffle();
    return List.generate(
      count,
      (index) {
        String name = _name[index];
        return UserModel(
          id: index,
          fullName: name,
          email: removeDiacritics(
            '****${name.toLowerCase().replaceAll(' ', '.').substring(3)}${_getRandomNumber(4)}${'@gmail.com'.toLowerCase()}',
          ),
          phoneNumber: '0${_getRandomNumber(3)}***${_getRandomNumber(3)}',
          avatar:
              'https://picsum.photos/200/300/?random=${_name.indexOf(name)}',
        );
      },
    );
  }

  static String _getRandomNumber(int count) {
    Random random = Random();
    String randomNumber = '';
    for (int i = 0; i < count; i++) {
      randomNumber += random.nextInt(10).toString();
    }
    return randomNumber;
  }

  static Future<UserModel> getUserInfo() async {
    await Future.delayed(const Duration(seconds: 3));

    return const UserModel(
      id: 100,
      email: 'beobiebom@gmail.com',
      fullName: 'Duc Nguyen',
    );
  }

  static OrganizationModel getOrganization() {
    return OrganizationModel(
      id: 10,
      name: 'GDSC - DUT',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      avatar:
          'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/chapter_banners/238560151_611157220289705_5018897076969677410_n.jpg',
      address: '',
      phoneNumber: '0905123123',
    );
  }

  static Future<UserModel> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 3));

    return UserModel(
      id: 1232312,
      email: 'gdscdut@gmil.com',
      avatar: 'https://i1.sndcdn.com/avatars-000340222160-d547n2-t500x500.jpg',
      projectPending: 12,
      projectCompleted: 5,
      projectOnGoing: 6,
      fullName: 'Kieu Thanh Duc',
      address: '54 Nguyễn Lương Bằng, Hoà Khánh, Liên Chiểu, Đà Nẵng',
      birthDay: DateTime.now(),
      gender: true,
      phoneNumber: '0905123123',
      workSpace: 'Đại học Công Nghệ - Đại học Quốc Gia TP.HCM',
    );
  }

  static Future<List<OrganizationModel>> getOrganizations() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      OrganizationModel(
        id: 10,
        name: 'GDSC - DUT',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        avatar:
            'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/chapter_banners/238560151_611157220289705_5018897076969677410_n.jpg',
        address: '54 Nguyễn Lương Bằng, Hoà Khánh, Liên Chiểu, Đà Nẵng',
        phoneNumber: '0905123123',
      ),
      OrganizationModel(
        id: 11,
        name: 'GDSC - DUT',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        avatar:
            'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/chapter_banners/238560151_611157220289705_5018897076969677410_n.jpg',
        address: '54 Nguyễn Lương Bằng, Hoà Khánh, Liên Chiểu, Đà Nẵng',
        phoneNumber: '0905123123',
      ),
      OrganizationModel(
        id: 12,
        name: 'GDSC - DUT',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        avatar:
            'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/chapter_banners/238560151_611157220289705_5018897076969677410_n.jpg',
        address: '54 Nguyễn Lương Bằng, Hoà Khánh, Liên Chiểu, Đà Nẵng',
        phoneNumber: '0905123123',
      ),
    ];
  }
}
