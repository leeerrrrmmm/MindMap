import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_map/features/tasks/data/datasource/map/map_remote_data_source.dart';
import 'package:mind_map/features/tasks/data/model/map_model/map_model.dart';

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  MapRemoteDataSourceImpl(
    FirebaseFirestore firestore,
    FirebaseAuth firebaseAuth,
  ) : _firestore = firestore,
      _firebaseAuth = firebaseAuth;

  @override
  Future<void> createMap({required MapModel map}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('maps')
        .doc(map.id)
        .set(map.toJson());
  }

  @override
  Future<List<MapModel>> fetchMaps() async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    final maps = await _firestore
        .collection('users')
        .doc(curUser)
        .collection('maps')
        .get();

    return maps.docs.map((doc) => MapModel.fromJson(doc.data())).toList();
  }

  @override
  Future<void> deleteMap({required String mapId}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }
    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('maps')
        .doc(mapId)
        .delete();
  }

  @override
  Future<void> updateMap({required MapModel map}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('maps')
        .doc(map.id)
        .update(map.toJson());
  }
}
