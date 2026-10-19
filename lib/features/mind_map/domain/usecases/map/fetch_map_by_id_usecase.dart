import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/mind_map/domain/repo/map_repo.dart';

class FetchMapByIdUsecase {
  final MapRepo _repo;
  const FetchMapByIdUsecase(this._repo);

  Future<MapEntity> call(String mapId) {
    return _repo.fetchMapById(mapId);
  }
}
