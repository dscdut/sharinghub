import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/user.model.dart';

abstract class UserMock {
  static AuthResponseDTO loginByEmail() {
    return AuthResponseDTO(
      user: UserModel(
        id: 100,
        email: 'beobiebom@gmail.com',
        fullName: 'Duc Nguyen',
      ),
    );
  }

  static Future<UserModel> getUserInfo() async {
    await Future.delayed(const Duration(seconds: 3));

    return UserModel(
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

  static Future<UserProfileModel> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 3));

    return UserProfileModel(
      id: 1232312,
      email: 'gdscdut@gmil.com',
      avatarURL:
          'https://i1.sndcdn.com/avatars-000340222160-d547n2-t500x500.jpg',
      projectPending: 12,
      projectCompleted: 5,
      projectOnGoing: 6,
      fullName: 'Kieu Thanh Duc',
      address: '54 Nguyễn Lương Bằng, Hoà Khánh, Liên Chiểu, Đà Nẵng',
      birthDay: DateTime.now(),
      gender: true,
      phoneNumber: '0905123123',
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
