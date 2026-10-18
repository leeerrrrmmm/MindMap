import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_map/features/auth/data/datasource/user_datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/model/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<void> createUser({required UserModel user}) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  @override
  Future<UserModel> getCurrentUser({required String uid}) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('User not found');
    }
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
