import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/models/address/coordinate.model.dart';
import 'package:mobile/data/models/place.model.dart';

@lazySingleton
class PlaceDataSource {
  final DioHelper _dioHelper;

  PlaceDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<List<PlaceModel>> getSuggestPlaces(String input) async {
    final HttpRequestResponse response =
        await _dioHelper.get('${Endpoints.autocompletePlace}&input=$input');

    final List<PlaceModel> places =
        (response.body['predictions'] as List<dynamic>)
            .map((e) => PlaceModel.fromJson(e))
            .where(
              (element) => element.types
                  .any((element2) => placeFilter.contains(element2)),
            )
            .toList();

    return places;
  }

  Future<Map<String, double>> getGeometry(String placeId) async {
    final HttpRequestResponse response = await _dioHelper.get(
      '${Endpoints.geoCode}&place_id=$placeId',
    );

    Map<String, dynamic> geoLocation =
        response.body['results'][0]['geometry']['location'];

    return {
      'lat': double.parse(
        (geoLocation['lat'] as double).toStringAsFixed(4),
      ),
      'lng': double.parse(
        (geoLocation['lng'] as double).toStringAsFixed(4),
      ),
    };
  }

  Future<List<CoordinateModel>> getCoordinates() async {
    final response = await _dioHelper.get(
      Endpoints.coordinators,
    );
    List<CoordinateModel> result = response.body
        .map<CoordinateModel>((e) => CoordinateModel.fromJson(e))
        .toList();
    return result;
  }
}
