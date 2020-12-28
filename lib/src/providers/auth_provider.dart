import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../services/sensor_service.dart';
import '../services/user_service.dart';

enum Status { Uninitialized, Authenticated, Authenticating, GoogleAuthenticating, Unauthenticated, Registering }

class AuthProvider extends ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  //Firebase Auth object
  FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given FirebaseUser
  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserModel(uid: user.uid, email: user.email ?? "", displayName: user.displayName, phoneNumber: user.phoneNumber, photoUrl: user.photoUrl);
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(String user, String email, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (result != null) {
        await result.user.updateProfile(displayName: user);
      }
      this._setSensorsToUserAndUpdate(result.user.uid,email,user);
      return _userFromFirebase(result.user);
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  void _setSensorsToUserAndUpdate(String id,String email,String user) {
    UserService _userService = UserService();
    CurrentUserModel _user = CurrentUserModel(id:id, email: email, userName: user);
    final _sensorService = SensorService();
    _sensorService.sensorsStream().listen((event) {
      CurrentUserModel.instance.sensors = event;
      _userService.setUser(_user);
    });
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle user sign in using google
  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.GoogleAuthenticating;
      notifyListeners();
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print("Error on the google = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
