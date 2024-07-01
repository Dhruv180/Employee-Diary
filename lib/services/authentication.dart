import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp User

  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty) {
        // register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // add user to your  firestore database
        print(cred.user!.uid);
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
        });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for sighout
  signOut() async {
    // await _auth.signOut();
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthMethod {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   // Sign in with email and password
//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return "success";
//     } on FirebaseAuthException catch (e) {
//       return e.message ?? "An error occurred";
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   // Sign in with Google
//   Future<String> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return "success";
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   // Get the currently signed-in user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//   }
// }
