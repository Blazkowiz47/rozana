import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rozana/model/models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserModel user;
  AuthService({this.user});
  final CollectionReference reference =  Firestore.instance.collection("user");
  void registerWithEmailAndPassword() async {
    await _auth.createUserWithEmailAndPassword(email: user.emailID.trim(), password: user.password.trim()).then((result) {
      print("Updating Data");
      reference.document(result.user.uid).setData({
        "FirstName" : user.firstName,
        "LastName" : "",
        "PhoneNumber" : user.phoneNumber,
        "EmailID" : user.emailID,
        "Password" : user.password,
        "WalletBalance" : "0",
        "Location" : [],
        "Cart" : [],
        "MyOrders" : [],
      });
    });
    await _auth.signInWithEmailAndPassword(email: user.emailID.trim(), password: user.password.trim());
  }

  void updateLocation () async {
    FirebaseUser currentUser = await _auth.currentUser();
    reference.document(currentUser.uid).updateData({
      "Location" : [jsonEncode(user.addresses[0].toJson())],
    });
  }


  Stream<FirebaseUser> get userStream {
    return _auth.onAuthStateChanged;
  }

}
