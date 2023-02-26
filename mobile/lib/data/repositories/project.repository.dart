import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/project.datasource.dart';
import 'package:mobile/data/models/home_module/home_project.model.dart';

@lazySingleton
class ProjectRepository {
  final ProjectDataSource _dataSource;

  ProjectRepository({
    required ProjectDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<List<HomeProjectModel>> getHomeProject() {
    return _dataSource.getHomeProject();
  }
}
