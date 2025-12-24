import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static Stream<User?> get userStream => _auth.userChanges();
  static User? get user => _auth.currentUser;

  static bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  static Future<void> register({required String username, required String email, required String password}) async {
    try{
    // ignore: unused_local_variable
    final credential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ).then((credential){
    credential.user?.sendEmailVerification();
    credential.user?.updateDisplayName(username);
  });
  } catch(e){
    rethrow;}
  }

  static Future<void> login({required String email, required String password}) async {
    try{
      await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    } catch(e){
      rethrow;
    }
  }

static Future<void> resetPassword({required String email}) =>_auth.sendPasswordResetEmail(email: email);

  static Future <void> logout() => _auth.signOut();
}