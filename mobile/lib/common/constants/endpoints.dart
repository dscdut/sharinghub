import 'package:mobile/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/api/v1';
  static String addressUrl = '${AppFlavor.addressURL}/api';

  static String login = '$apiUrl/auth/login';
  static String register = '$apiUrl/auth/register';

  // User
  static String user = '$apiUrl/users/me';

  // Organization
  static String organization = '$apiUrl/organizations';
  static String myOrganizations = '$organization/my-organizations';

  // Campaign
  static String campaignByOrganization = '$apiUrl/organizations';
  static String campaigns = '$apiUrl/campaigns';

  // Coordinators
  static String coordinators = '$apiUrl/campaigns/coordinates';

  static String autocompletePlace =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${AppFlavor.googleMapApiKey}&components=country:vn&region=vn&types=administrative_area_level_3|administrative_area_level_2';

  static String geoCode ='https://maps.googleapis.com/maps/api/geocode/json?key=${AppFlavor.googleMapApiKey}';

  static String province = '$addressUrl/p';
  static String district = '$addressUrl/d';
      
}
