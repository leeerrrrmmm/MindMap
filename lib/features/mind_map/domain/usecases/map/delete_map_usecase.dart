import 'package:mind_map/features/mind_map/domain/repo/map_repo.dart';

class DeleteMapUsecase {
  final MapRepo _mapRepo;

  DeleteMapUsecase({required MapRepo mapRepo}) : _mapRepo = mapRepo;

  Future<void> call(String mapId) async {
    return _mapRepo.deleteMap(mapId);
  }
}
