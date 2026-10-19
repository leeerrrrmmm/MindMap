import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/mind_map/domain/repo/map_repo.dart';

class UpdateMapUsecase {
  final MapRepo _mapRepo;

  UpdateMapUsecase({required MapRepo mapRepo}) : _mapRepo = mapRepo;

  Future<void> call(MapEntity map) async {
    return _mapRepo.updateMap(map);
  }
}
