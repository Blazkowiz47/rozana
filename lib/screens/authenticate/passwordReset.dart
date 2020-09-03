import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _obscureText = true;
  var textDecoration = TextDecoration.none;
  String otp;
  String email;

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
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: w * 0.1, right: w * 0.07),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: w * 0.09,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Forgot Password",
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
              Padding(
                padding: EdgeInsets.only(top: h*0.05),
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  width: w * 0.7,
                  height: h * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/loginlogo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( top : h*0.02 , bottom: 2.0, left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your E-mail here",
                  ),
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Enter OTP",
              //     ),
              //     obscureText: _obscureText,
              //     onChanged: (val) {
              //       setState(() => otp = val);
              //     },
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       textDecoration = TextDecoration.underline;
              //     });
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 15.0, top: 10.0),
              //     child: Container(
              //       alignment: Alignment.centerRight,
              //       child: Text(
              //         "Get OTP code",
              //         textAlign: TextAlign.end,
              //         style: GoogleFonts.openSans(
              //           textStyle: TextStyle(
              //             fontSize: 15.0,
              //             color: Colors.redAccent,
              //           ),
              //           decoration: textDecoration,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  left: w * 0.2,
                  right: w * 0.2,
                  top: h * 0.1,
                  bottom: 0.0,
                ),
                child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Hexcolor("6BC65A"),
                    borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
                  ),
                  child: FlatButton(
                    onPressed: ()async {
                      print("check");
                      try{
                        if(email.contains("@")&&email.contains(".")){
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                        }
                        else{
                          return showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(title: Text("Error"),content: Text("Please enter correct Email"),actions: <Widget>[
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
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(title: Text("Success"),content: Text("Password Reset Link has been sent to your E=mail. Please follow the instructions there."),actions: <Widget>[
                                FlatButton(
                                  child: Text('Approve'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],);
                            }
                        );
                      }catch(e){
                        return showDialog(context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(title: Text("Failure"),content: Text("Password Reset failed due to : \n$e"),actions: <Widget>[
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
                      "Reset Password",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: h * 0.035,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
