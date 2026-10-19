import 'package:mind_map/features/mind_map/data/datasource/map/map_remote_data_source.dart';
import 'package:mind_map/features/mind_map/data/model/map_model/map_model.dart';
import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/mind_map/domain/repo/map_repo.dart';

class MapRepositoryImpl implements MapRepo {
  final MapRemoteDataSource _mapRemoteDataSource;

  MapRepositoryImpl({required MapRemoteDataSource mapRemoteDataSource})
    : _mapRemoteDataSource = mapRemoteDataSource;

  @override
  Future<void> createMap(MapEntity map) async {
    final model = MapModel.fromEntity(map);
    return _mapRemoteDataSource.createMap(map: model);
  }

  @override
  Future<List<MapEntity>> fetchMaps() async {
    final models = await _mapRemoteDataSource.fetchMaps();
    return models.map((model) => MapModel.fromEntity(model)).toList();
  }

  @override
  Future<MapEntity> fetchMapById(String mapId) async {
    final mapById = await _mapRemoteDataSource.fetchMapById(mapId);
    return mapById;
  }

  @override
  Future<void> deleteMap(String mapId) async {
    return _mapRemoteDataSource.deleteMap(mapId: mapId);
  }

  @override
  Future<void> updateMap(MapEntity map) async {
    final model = MapModel.fromEntity(map);
    return _mapRemoteDataSource.updateMap(map: model);
  }
}
