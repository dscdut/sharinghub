import 'package:mobile/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/api';

  static String login = '$apiUrl/login';
  static String register = '$apiUrl/register';

  static String autocompletePlace =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyD8y0Rb-Hg6n26z-MP30neOY3yxoBb-Ki0&components=country:vn&region=vn&types=geocode';

  static String geoCode =
      'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD8y0Rb-Hg6n26z-MP30neOY3yxoBb-Ki0';
}
