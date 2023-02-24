import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/user.model.dart';

abstract class UserMock {
  static AuthResponseDTO loginByEmail() {
    return AuthResponseDTO(
      user: UserModel(email: 'beobiebom@gmail.com', name: 'Duc Nguyen'),
    );
  }

  static UserModel getUserInfo() {
    return UserModel(email: 'beobiebom@gmail.com', name: 'Duc Nguyen');
  }
}
