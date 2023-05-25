import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/repository/firebase_auth/base_firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends BaseAuthRepository {
  final firebaseAuthCurrentUser =
      FirebaseAuth.instance.currentUser != null ? '/bottom' : '/welcome';
  final authDisplayName = "${FirebaseAuth.instance.currentUser?.displayName}";

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firebaseAuth.currentUser?.updateDisplayName("$firstName $lastName");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await firebaseAuth.currentUser?.delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateDisplayName({required String name}) async {
    try {
      await firebaseAuth.currentUser?.updateDisplayName(name);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
