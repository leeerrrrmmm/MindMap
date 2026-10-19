import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/mind_map/domain/repo/map_repo.dart';

class CreateMapUsecase {
  final MapRepo _mapRepo;

  CreateMapUsecase({required MapRepo mapRepo}) : _mapRepo = mapRepo;

  Future<void> call(MapEntity map) async {
    return _mapRepo.createMap(map);
  }
}
