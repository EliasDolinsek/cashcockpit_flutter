import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signUpUser(email, password) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;
  }

  Future<FirebaseUser> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }
}