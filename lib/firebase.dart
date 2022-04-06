import 'package:firebase_auth/firebase_auth.dart';

Future<void> checkAuth() async {
  try {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Signed In Already");
    } else {
      print("Signed Out");
    }
  } catch (e) {
    print(e);
  }
}

Future<void> signUp(String email, String password) async {
  try {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    print(e);
  }
}

//Future<void> signIn(String email, String password) async {
//  try {
//    UserCredential user = await FirebaseAuth.instance
//        .signInWithEmailAndPassword(email: email, password: password);
//  } catch (e) {
//    print(e);
//  }
//}

Future<void> signOut() async {
  try {
    FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e);
  }
}

Future<void> resetPassword(String email) async {
  try {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    print(e);
  }
}
