import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mind_map/features/auth/data/datasource/auth_datasource/auth_remote_datasource.dart';
import 'package:mind_map/features/auth/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

// data/datasource/auth_remote_datasource_impl.dart
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final String _googleServerClientId;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required String googleServerClientId,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _googleServerClientId = googleServerClientId;

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw Exception('User is null');

    return UserModel.fromFirebase(user, customId: const Uuid().v4());
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw Exception('User is null');

    return UserModel.fromFirebase(user, customId: const Uuid().v4());
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    await _googleSignIn.initialize(
      serverClientId: _googleServerClientId.isEmpty
          ? null
          : _googleServerClientId,
    );

    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) throw Exception('Google sign in failed');

    return UserModel.fromFirebase(user, customId: const Uuid().v4());
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
