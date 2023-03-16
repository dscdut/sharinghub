import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/remote/place.datasource.dart';
import 'package:mobile/data/models/place.model.dart';

@lazySingleton
class PlaceRepository {
  final PlaceDataSource _dataSource;

  PlaceRepository({required PlaceDataSource placeDataSource})
      : _dataSource = placeDataSource;

  Future<List<PlaceModel>> getSuggestPlaces(String input) {
    return _dataSource.getSuggestPlaces(input);
  }

  Future<Map<String, double>> getGeometry(String placeId) {
    return _dataSource.getGeometry(placeId);
  }
}
