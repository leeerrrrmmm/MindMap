// data/model/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_map/features/auth/domain/entity/user_entiny.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.customId,
    required super.email,
    super.firstName,
    super.lastName,
    super.goal,
    required super.mood,
    super.imageUrl,
    required super.createdAt,
  });

  factory UserModel.fromFirebase(
    User user, {
    required String customId,
    String? goal,
    int mood = 0,
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) {
    return UserModel(
      uid: user.uid,
      customId: customId,
      email: user.email ?? '',
      firstName: firstName ?? user.displayName,
      lastName: lastName,
      goal: goal,
      mood: mood,
      imageUrl: imageUrl ?? user.photoURL,
      createdAt: DateTime.now(),
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uid: user.uid,
      customId: user.customId,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      goal: user.goal,
      mood: user.mood,
      imageUrl: user.imageUrl,
      createdAt: user.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final createdAtRaw = json['createdAt'];
    return UserModel(
      uid: json['uid'] as String,
      customId: json['customId'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      goal: json['goal'] as String?,
      mood: (json['mood'] ?? 0) as int,
      imageUrl: json['imageUrl'] as String?,
      createdAt: createdAtRaw is Timestamp
          ? createdAtRaw.toDate()
          : DateTime.parse(createdAtRaw as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'customId': customId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'goal': goal,
      'mood': mood,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
