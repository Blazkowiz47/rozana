import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/authenticate/authenticate.dart';
import 'package:rozana/screens/authenticate/location.dart';
import 'package:rozana/screens/authenticate/login.dart';
import 'package:rozana/screens/home/homepage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  var textDecoration = TextDecoration.none;
  String name;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;
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
                          "Register",
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
                height: h * 0.3,
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Name",
                  ),
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: "E-mail",
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone Number",
                  ),
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                  obscureText: _obscureText,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Confirm Password",
                  ),
                  obscureText: _obscureText,
                  onChanged: (val) {
                    setState(() => confirmPassword = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: w * 0.1,
                  right: w * 0.1,
                  top: h * 0.05,
                  bottom: 10.0,
                ),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Hexcolor("6BC65A"),
                    borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      print("check");
                      print(
                        "$confirmPassword $email $name $password $phoneNumber",
                      );
                      if (confirmPassword != password)
                        return showDialog(context: context ,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Please Check your password"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      if (password.length <6)
                        return showDialog(context: context ,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Please Keep the password of atleast 6 chahracters"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Approve'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      try{
                        int phone = int.parse(phoneNumber);
                        if(phone.toString().length != 10)
                          return showDialog(context: context , builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Check your Phone Number"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Approve'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                      }catch(e){
                        return showDialog(context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Please Check your Phone Number"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      }
                      if(!(email.contains("@") && email.contains(".")))
                        return showDialog(context: context , builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please Check your email"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Approve'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                      //Try Registering the user
                      //Check if phone number exists
                      QuerySnapshot doc = await Firestore.instance.collection("user").where("PhoneNumber" , isEqualTo: phoneNumber).getDocuments();
                      if(doc.documents.length != 0) {
                        return showDialog(context: context , builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Phone Number is Already registered"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      }
                      //If registration is successful go to locations page
                      try{
                        UserModel user = UserModel(firstName: name , password: password , phoneNumber:  phoneNumber , emailID: email);
                        AuthService(user: user).registerWithEmailAndPassword();
                        //finished registration
                        Navigator.of(context).pushNamed('/register/location');
                      }catch(e){
                        return showDialog(context: context , builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Registration Failed"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      }

                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Text(
                  "Skip Register",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.redAccent,
                    ),
                    decoration: textDecoration,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed('/login'),
                      child: Text(
                        "Login",
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
