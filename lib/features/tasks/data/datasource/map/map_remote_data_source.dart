import 'package:mind_map/features/tasks/data/model/map_model/map_model.dart';

abstract interface class MapRemoteDataSource {
  Future<void> createMap({required MapModel map});
  Future<List<MapModel>> fetchMaps();
  Future<void> deleteMap({required String mapId});
  Future<void> updateMap({required MapModel map});
}
