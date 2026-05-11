import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mind_map/features/auth/data/datasource/auth_repote_datasource.dart';
import 'package:mind_map/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:mind_map/features/auth/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required UserRemoteDataSource userRemoteDataSource,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _userRemoteDataSource = userRemoteDataSource;

  final String _googleServerClientId = String.fromEnvironment(
    dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '',
    defaultValue: '',
  );

  final Uuid uuid = Uuid();

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String? goal,
    required int mood,
  }) async {
    final String customId = uuid.v4();

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('User is null');
    }

    final user = UserModel.fromFirebase(
      firebaseUser,
      customId: customId,
      goal: goal,
      mood: mood,
    );

    /// SAVE TO FIRESTORE
    await _userRemoteDataSource.createUser(user: user);

    return user;
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final String customId = uuid.v4();

    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('User is null');
    }

    final user = UserModel.fromFirebase(firebaseUser, customId: customId);

    /// SAVE TO FIRESTORE
    await _userRemoteDataSource.createUser(user: user);

    return user;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final String customId = uuid.v4();

    try {
      await _googleSignIn.initialize(
        serverClientId: _googleServerClientId.isEmpty
            ? null
            : _googleServerClientId,
      );

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) throw Exception('Google sign in failed');

      final user = UserModel.fromFirebase(firebaseUser, customId: customId);

      /// SAVE TO FIRESTORE
      await _userRemoteDataSource.createUser(user: user);

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
