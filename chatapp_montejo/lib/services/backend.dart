import 'package:chatapp_montejo/models/user.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthenticationMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserClass defaultUser = new UserClass(userId: "00000");

  //Receives a User object and returns only the User ID
  UserClass _userFromFirebaseUser(User user){
    return UserClass(userId:user.uid);
  }

  //Auth change user stream (UserClass ni siya sauna)
  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  //Sign in With Email and Password
  Future signinWithEmailandPassword(String email, String password) async { 
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      // User firebaseUser = _auth.currentUser;
      User? firebaseUser = result.user;
      return firebaseUser;
      // return _userFromFirebaseUser(firebaseUser);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    return _auth.currentUser;
  }
  Future signOut() async {
    try{
      await _auth.signOut();
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
