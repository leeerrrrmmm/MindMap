import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_map/features/tasks/data/datasource/task_remote_data_source.dart';
import 'package:mind_map/features/tasks/data/model/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  TaskRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  @override
  Future<void> createTask({required TaskModel task}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('tasks')
        .doc(task.id)
        .set(task.toJson());
  }

  @override
  Future<List<TaskModel>> fetchTasks() async {
    final curUser = _firebaseAuth.currentUser?.uid;

    try {
      if (curUser == null) {
        throw Exception('Current user is null');
      }

      final tasks = await _firestore
          .collection('users')
          .doc(curUser)
          .collection('tasks')
          .get();

      return tasks.docs.map((doc) => TaskModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TaskModel> fetchTaskById({required String taskId}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    final task = await _firestore
        .collection('users')
        .doc(curUser)
        .collection('tasks')
        .doc(taskId)
        .get();
    return TaskModel.fromJson(task.data()!);
  }

  @override
  Future<void> updateTask({required TaskModel task}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    final curUser = _firebaseAuth.currentUser?.uid;

    if (curUser == null) {
      throw Exception('Current user is null');
    }

    await _firestore
        .collection('users')
        .doc(curUser)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
