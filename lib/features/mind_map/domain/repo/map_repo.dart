import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';

abstract interface class MapRepo {
  Future<void> createMap(MapEntity map);
  Future<List<MapEntity>> fetchMaps();
  Future<MapEntity> fetchMapById(String mapId);
  Future<void> deleteMap(String mapId);
  Future<void> updateMap(MapEntity map);
}
