import 'package:mobile/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/api';

  static String login = '$apiUrl/login';
  static String register = '$apiUrl/register';
}
