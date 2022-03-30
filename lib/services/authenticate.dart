import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_2022/models/userModel.dart';

class AuthenticateService {
  // Create a FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on credential's user?
  UserModel? _userFromCredUser(User? user) {
    // take the firebase user and return a different type of user - with less information
    // if true return the uid if false return null
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Authenticate change user stream
  Stream<UserModel?> get user {
    // return when notified about changes to user sign in state
    return _auth
        .authStateChanges()
        // map _auth user to our user in _userFromCredUser
        .map((User? user) => _userFromCredUser(user));
  }

  // *** Anonymous Sign In - Async returns Future***
  Future anonSignIn() async {
    // set up try catch
    try {
      // use await as it can take some time to complete - returns as UserCredential
      UserCredential authResult = await _auth.signInAnonymously();
      // save the users results - use User? typing to match with UserCredential
      User? user = authResult.user;
      // return the custom user object from _userFromCredUser
      return _userFromCredUser(user);
    } catch (e) {
      // catch errors and print to console
      print(e.toString());
      // return null if there are errors
      return null;
    }
  }

  // *** Email & Password Sign In ***
  Future signInUser(String email, String password) async {
    try {
      // make a request to firebase to sign in a user with email and password and pass both
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // save the user credentials in a user
      User? user = authResult.user;
      // return user based on user model
      return _userFromCredUser(user);
    } catch (e) {
      // catch errors and print to console
      print(e.toString());
      // return null if there are errors
      return null;
    }
  }

  // *** Register with Email & Password ***
  Future registerUser(String email, String password) async {
    try {
      // make a request to firebase to create a user with email and password and pass both
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // save the user credentials in a user
      User? user = authResult.user;
      // return user based on user model
      return _userFromCredUser(user);
    } catch (e) {
      // catch errors and print to console
      print(e.toString());
      // return null if there are errors
      return null;
    }
  }

  // *** Log Out Method ***
  Future logOut() async {
    // set up try catch
    try {
      // try return auth.signOut method
      return await _auth.signOut();
    } catch (e) {
      // if that fails catch errors and print to console
      print(e.toString());
      // return null if errors exist
      return null;
    }
  }
}

/*

FirebaseUser has been changed to User - watch for typing of user?

AuthResult has been changed to UserCredential

GoogleAuthProvider.getCredential() has been changed to GoogleAuthProvider.credential()

onAuthStateChanged which notifies about changes to the user's sign-in state was replaced with authStateChanges()

currentUser() which is a method to retrieve the currently logged in user, was replaced with the property currentUser and it no longer returns a Future<FirebaseUser>

*/
