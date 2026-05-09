class UserEntity {
  final String uid;

  /// public app id
  final String customId;

  final String email;

  final String? firstName;
  final String? lastName;

  final String? goal;

  final int mood;

  final String? imageUrl;

  final DateTime createdAt;

  const UserEntity({
    required this.uid,
    required this.customId,
    required this.email,
    this.firstName,
    this.lastName,
    this.goal,
    required this.mood,
    this.imageUrl,
    required this.createdAt,
  });
}
