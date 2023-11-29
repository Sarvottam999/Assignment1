import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/validationModel.dart';
import 'package:crypto/crypto.dart';

class FormProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get name => _name;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? _errorText;
  User? user;

  FirebaseAuth _auth = FirebaseAuth.instance;

  // check if user is login in
  bool isUserLoggedIn() {
    var user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  // sign out
  Future signOut() async {
    await _auth.signOut();
  }

  Future signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email.value!,
        password: _password.value!,
      );

      user = userCredential.user;


      String hashedPassword =
          sha256.convert(utf8.encode(_password.value!)).toString();

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': _name.value!,
        'email': _email.value!,
        'password': hashedPassword,
      });

      return true;
    } catch (e) {
      return e;
    }
  }

  Future signIn(
      // String email, String password
      ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.value!,
        password: _password.value!,
      );

      user = userCredential.user;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user!.uid).get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please Enter a Valid Email');
    }
    notifyListeners();
  }

  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
    } else {
      _password =
          ValidationModel(null, 'Password Must be at least 6 characters long');
    }
    notifyListeners();
  }

  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationModel(val, null);
    } else {
      _name = ValidationModel(null,
          'Please enter a valid name, Must be at least 4 characters long');
    }
    notifyListeners();
  }

  bool get validate {
    return _email.value != null && _password.value != null;
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = new RegExp(r"^.{4,}$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {

    final passwordRegExp = RegExp(r'^.{6,}$');

    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
