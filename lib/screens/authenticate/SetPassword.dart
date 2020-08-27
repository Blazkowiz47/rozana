import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
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
              Container(
                padding: EdgeInsets.all(0.0),
                margin: EdgeInsets.all(0.0),
                width: w * 0.7,
                height: h * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/loginlogo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0, left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter New Passsword",
                  ),
                  // obscureText: true,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  // obscureText: true,
                  onChanged: (val) {
                    setState(() => otp = val);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: w * 0.1,
                  right: w * 0.1,
                  top: h * 0.05,
                  bottom: 0.0,
                ),
                child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Hexcolor("6BC65A"),
                    borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      print("check");
                    },
                    child: Text(
                      "NEXT",
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
