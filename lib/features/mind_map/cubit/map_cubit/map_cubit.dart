import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/mind_map/domain/usecases/map/create_map_usecase.dart';
import 'package:mind_map/features/mind_map/domain/usecases/map/delete_map_usecase.dart';
import 'package:mind_map/features/mind_map/domain/usecases/map/fetch_map_by_id_usecase.dart';
import 'package:mind_map/features/mind_map/domain/usecases/map/fetch_maps_usecase.dart';
import 'package:mind_map/features/mind_map/domain/usecases/map/update_map_usecase.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final CreateMapUsecase _createMapUsecase;
  final FetchMapsUsecase _fetchMapsUsecase;
  final FetchMapByIdUsecase _fetchMapByIdUsecase;
  final DeleteMapUsecase _deleteMapUsecase;
  final UpdateMapUsecase _updateMapUsecase;

  MapCubit({
    required CreateMapUsecase createMapUsecase,
    required FetchMapsUsecase fetchMapsUsecase,
    required FetchMapByIdUsecase fetchMapByIdUsecase,
    required DeleteMapUsecase deleteMapUsecase,
    required UpdateMapUsecase updateMapUsecase,
  }) : _createMapUsecase = createMapUsecase,
       _fetchMapsUsecase = fetchMapsUsecase,
       _fetchMapByIdUsecase = fetchMapByIdUsecase,
       _deleteMapUsecase = deleteMapUsecase,
       _updateMapUsecase = updateMapUsecase,
       super(MapInitial());

  Future<void> createMap(MapEntity map) async {
    emit(MapLoading());

    try {
      await _createMapUsecase.call(map);
      emit(MapsLoaded(maps: await _fetchMapsUsecase.call()));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> fetchMaps() async {
    try {
      emit(MapLoading());

      final maps = await _fetchMapsUsecase.call();

      emit(MapsLoaded(maps: maps));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> fetchMapById(String mapId) async {
    try {
      emit(MapLoading());

      final mapById = await _fetchMapByIdUsecase(mapId);

      emit(MapLoaded(mapById: mapById));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> deleteMap(String mapId) async {
    emit(MapLoading());

    try {
      await _deleteMapUsecase.call(mapId);
      emit(MapsLoaded(maps: await _fetchMapsUsecase.call()));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> updateMap(MapEntity map) async {
    emit(MapLoading());

    try {
      await _updateMapUsecase.call(map);
      emit(MapsLoaded(maps: await _fetchMapsUsecase.call()));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }
}
