import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/home_module/home_project.model.dart';

import 'package:mobile/data/datasources/home.mock.dart';

@lazySingleton
class ProjectDataSource {
  Future<List<HomeProjectModel>> getHomeProject() async {
    await Future.delayed(const Duration(seconds: 3));
    return HomeMock.getHome();
  }
}
