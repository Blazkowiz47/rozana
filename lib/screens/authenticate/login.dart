import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rozana/screens/authenticate/passwordReset.dart';
import 'package:rozana/screens/authenticate/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  var textDecoration = TextDecoration.none;
  String email;
  String password;
  bool _phoneAuthentication = false;
  String verificationID; // Contains the verification ID
  AuthCredential userCredential;
  //setiing upf phone auth functions
  Future verifyPhone (String phoneNumber) async {

    //Defining few methods first

    final PhoneCodeSent phoneCodeSent = (String verID , [int forceResendingToken]) {
      //this method is called when otp is sent to user
      setState(() {
        verificationID = verID;//verification ID is set to actual ID that is provided when Phone Code is Sent
      });
      print( 'Phone COdE HAS been Sent and ver ID is\n$verificationID');
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      //this method is called when auto retrieval timeout is over
      setState(() {
        verificationID = verID;//verification ID is set to actual ID that is provided when Phone Code is Sent
      });
      print("\nAuto retrieval time out");
    };

    final PhoneVerificationFailed verificationFailed = (AuthException e) {
      print('\n failed');
      print(e.toString());
    };

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) {
      setState(() {
        userCredential = credential;
        print(credential.providerId.toLowerCase());
      });
      print("success");
    };


    //Method to start verification process
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,//phone-number is supplied
        timeout: Duration(seconds : 10),//timeout duration
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );

  }
  Future signIn (String verID , AuthCredential credential , String otp , String phone) async {
    if (credential == null) {
      //In-case Auto retrieve doesn't work
      setState(() {
        credential = PhoneAuthProvider.getCredential(verificationId: verID, smsCode: otp);
        print(credential.providerId.toLowerCase());
      });
      print("Manual login success");
      QuerySnapshot doc = await Firestore.instance.collection("user").where("PhoneNumber" , isEqualTo: phone).getDocuments();
      if(doc.documents.length == 0){
        return  showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(title: Text("Error"),content: Text("Mobile Number not Registered"),actions: <Widget>[
                FlatButton(
                  child: Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],);
            }
        );
      }
      if(doc.documents.length == 1){
        try {
          print(doc.documents[0].data["PhoneNumber"]);

          FirebaseAuth _auth = FirebaseAuth.instance;
          AuthResult result = await _auth.signInWithEmailAndPassword(
              email: doc.documents[0].data["EmailID"].trim(), password: doc.documents[0].data["Password"].trim());
          if(result.user.uid != null){
            print("signing successful");
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          }
      }catch(e){
          return  showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(title: Text("Error"),content: Text("Mobile Number not Registered"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Approve'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
      }
    }
    else{
      //In-case Auto retrieve works
      FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseAuth.instance.signOut();
      QuerySnapshot doc = await Firestore.instance.collection("user").where("PhoneNumber" , isEqualTo: phone).getDocuments();
      if(doc.documents.length == 0){
        return  showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(title: Text("Error"),content: Text("Mobile Number not Registered"),actions: <Widget>[
                FlatButton(
                  child: Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],);
            }
        );
      }
      if(doc.documents.length == 1){
        print(doc.documents[0].data["PhoneNumber"]);
        try {
          FirebaseAuth _auth = FirebaseAuth.instance;
          AuthResult result = await _auth.signInWithEmailAndPassword(
              email: doc.documents[0].data["EmailID"].trim(), password: doc.documents[0].data["Password"].trim());
          if(result.user.uid != null){
            print("signing successful");
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          }
        }catch(e){
          return  showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(title: Text("Error"),content: Text("Mobile Number not Registered"),actions: <Widget>[
                  FlatButton(
                    child: Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],);
              }
          );
        }
      }

    }
    print("Auto login success");
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: h,
        width: w,
        color: Hexcolor("#FBFBFB"),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: w,
                  height: h * 0.11,
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Hexcolor("6BC65A"),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(h * 0.022),
                      bottomRight: Radius.circular(h * 0.022),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.02, top: h * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: w * 0.1, right: w * 0.2),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: w * 0.09,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Log In",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: h * 0.035,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                margin: EdgeInsets.all(0.0),
                width: w * 0.7,
                height: h * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/loginlogo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                child: TextFormField(
                  keyboardType: _phoneAuthentication ? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: _phoneAuthentication
                        ? "Mobile Number"
                        : "E-mail",
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: TextFormField(
                  keyboardType: _phoneAuthentication ? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: _phoneAuthentication
                        ? null
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                    prefixIcon: Icon(Icons.lock),
                    hintText:
                        _phoneAuthentication ? "Enter OTP code" : "Password",
                  ),
                  obscureText: _obscureText,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    textDecoration = TextDecoration.underline;
                  });

                  _phoneAuthentication
                      ? verifyPhone('+91'+ email.trim())
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _phoneAuthentication
                          ? "Get OTP code"
                          : "Forgot Password?",
                      textAlign: TextAlign.end,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ),
                        decoration: textDecoration,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: w * 0.1,
                  right: w * 0.1,
                  top: 20,
                  bottom: 0.0,
                ),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Hexcolor("6BC65A"),
                    borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      print("check");
                      if(_phoneAuthentication){
                        // try phoneAuthentication here
                        if(password != null || password.length != 6){
                          return signIn(verificationID, userCredential, password.trim() , email.trim());
                        }
                        else{
                          return showDialog(context: context,
                          builder: (BuildContext context) {
                           return AlertDialog(title: Text("Error"),content: Text("Please enter otp"),actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],);
                          }
                          );
                        }
                      }
                      //try email authentication here
                      try {
                        AuthResult result = await _auth.signInWithEmailAndPassword(
                            email: email.trim(), password: password.trim());
                        if(result.user.uid != null){
                          print("signing successful");
                          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                        }
                      }catch(e) {
                        print("error in signing");
                        return  showDialog(context: context,
                          builder: (BuildContext context){
                          return AlertDialog(title: Text("Error"),content: Text("Sign In failed : \n $e"),actions: <Widget>[
                            FlatButton(
                              child: Text('Approve'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],);
                          }
                        );

                      }
                    },
                    child: Text(
                      _phoneAuthentication ? "LOGIN WITH OTP" : "LOGIN",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: w * 0.1,
                  right: w * 0.1,
                  top: 15,
                  bottom:10,
                ),
                child: Container(
                  width: 180,
                  height: h * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
                  ),
                  child: OutlineButton(
                    onPressed: () {
                      print("check");
                      setState(() {
                        _phoneAuthentication = !_phoneAuthentication;
                      });
                    },
                    child: Text(
                      _phoneAuthentication ? "LOGIN" : "LOGIN WITH OTP",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    textDecoration = TextDecoration.underline;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      textDecoration = TextDecoration.underline;
                    });
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: Text(
                    "Skip Log in",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.redAccent,
                      ),
                      decoration: textDecoration,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => Register(),
                      )),
                      child: Text(
                        "Register",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
