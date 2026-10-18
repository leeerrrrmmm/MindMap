import 'package:mind_map/features/tasks/domain/entity/map_entity.dart';
import 'package:mind_map/features/tasks/domain/repo/map_repo.dart';

class FetchMapsUsecase {
  final MapRepo _mapRepo;

  FetchMapsUsecase({required MapRepo mapRepo}) : _mapRepo = mapRepo;

  Future<List<MapEntity>> call() async {
    return _mapRepo.fetchMaps();
  }
}
