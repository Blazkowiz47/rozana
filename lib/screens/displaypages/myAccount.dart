import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/authenticate/location.dart';
import 'package:rozana/screens/displaypages/giftCards.dart';
import 'package:rozana/screens/displaypages/myWallet.dart';
import 'package:rozana/screens/displaypages/myorder.dart';
import 'package:rozana/screens/personal.dart';
import 'package:rozana/screens/displaypages/notificatios.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  UserModel user;
  bool userLogged = false;
  int select = 0;
  String uid;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      print("Got User");
      if(value != null){
        DatabaseService(uid: value.uid).getUserModel().then((doc) {
          setState((){
            user = doc;
            userLogged = true;
            uid = value.uid;
          });
          print("User Set");
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            width: width,
            // height: height * 0.25,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: width * 0.18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: width * 0.07,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                userLogged ? user.firstName : "Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.044,
                                ),
                              ),
                              SizedBox(width: width*0.3,),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Personal(
                                      user :  userLogged ? user : null,
                                      uid : uid,
                                    ),
                                  ));
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              userLogged ? user.phoneNumber : "Mobile Number",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.022,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.02),
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.9,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: width * 0.08,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(userLogged ? user.addresses[select].addressLine1 : "Location Line 1"),
                              Text(userLogged ? user.addresses[select].addressLine2 : "Location Line 2"),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.0,
                          ),
                          OutlineButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder:(context) => GetLocation(),
                              ));
                            },
                            child: Text("Change"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyOrder(),
                ));
              },
              leading: Icon(
                Icons.restore,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "My Orders",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyWallet(user: user,),
                ));
              },
              leading: Icon(
                Icons.account_balance_wallet,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "My Wallet",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.credit_card,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "My Payments",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Padding(
                padding:  EdgeInsets.only(right: 15.0),
                child: Text(
                  userLogged ? user.walletBalance : "",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NotificationPage(), ));
              },
              leading: Icon(
                Icons.notifications,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "Notifications",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GiftCards(),
                ));
              },
              leading: Icon(
                Icons.card_giftcard,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "My Gift Card",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {},
              leading: Icon(
                Icons.location_on,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                "My Delivery Address",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                userLogged ?  FirebaseAuth.instance.signOut() : null;
                userLogged ? Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false) : Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false) ;
              },
              leading: Icon(
                MdiIcons.logout,
                color: Colors.black38,
                size: width * 0.09,
              ),
              title: Text(
                userLogged ? "Log Out" : "Log In",
                style: GoogleFonts.openSans(
                  fontSize: height * 0.026,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
