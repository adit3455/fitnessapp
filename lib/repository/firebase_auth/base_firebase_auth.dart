import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
  Future<void> signIn({required String email, required String password});
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> deleteUser();
  Future<void> updateDisplayName({required String name});
}
