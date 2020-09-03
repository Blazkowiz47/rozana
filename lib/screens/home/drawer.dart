import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/displaypages/contactus.dart';
import 'package:rozana/screens/displaypages/faqs.dart';
import 'package:rozana/screens/displaypages/giftCards.dart';
import 'package:rozana/screens/displaypages/myAccount.dart';
import 'package:rozana/screens/displaypages/myWallet.dart';
import 'package:rozana/screens/displaypages/myorder.dart';
import 'package:rozana/screens/displaypages/referanndearn.dart';
import 'package:rozana/screens/personal.dart';

class AppDrawer extends StatefulWidget {
  final Function navigateFromDrawerToCart;
  final Function navigateFromDrawerToOffers;
  final Function navigateFromDrawerToCategories;

  AppDrawer({
    this.navigateFromDrawerToCart,
    this.navigateFromDrawerToOffers,
    this.navigateFromDrawerToCategories,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserModel user;
  bool userLogged = false;
  String uid ;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      if(value != null){
        setState(() {
          uid = value.uid;
        });
        DatabaseService(uid: value.uid).getUserModel().then((value) {
          setState((){
            user = value;
            userLogged = true;
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
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            width: width,
            height: height * 0.25,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.all(0.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: width * 0.16,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          userLogged ? "${user.firstName} ${user.lastName}" : "User Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.04,
                          ),
                        ),
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
                          child: Text(
                            userLogged ? "Edit your profile" : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.022,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          userLogged ? "Savings Meter  0.0" : "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.all(0.0),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          Icons.home,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Home",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      // child: GestureDetector(
                      //   onTap: (){
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: Row(
                      //     children: [
                      //     Icon(
                      //         Icons.home,
                      //         color: Theme.of(context).primaryColor,
                      //         size: width * 0.065,
                      //       ),
                      //     SizedBox(width: 10.0,),
                      //     Text(
                      //         "Home",
                      //         style: GoogleFonts.openSans(
                      //           fontSize: height * 0.028,
                      //           color: Colors.black38,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,

                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyAccount(),
                          ));
                        },
                        leading: Icon(
                          Icons.account_box,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "My Account",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      // child: GestureDetector(
                      //   onTap: (){
                      //         Navigator.of(context).pop();
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => MyAccount(),
                      //         ));
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.account_box,
                      //         color: Theme.of(context).primaryColor,
                      //         size: width * 0.065,
                      //       ),
                      //       SizedBox(width: 10.0,),
                      //       Text(
                      //         "My Account",
                      //         style: GoogleFonts.openSans(
                      //           fontSize: height * 0.028,
                      //           color: Colors.black38,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: 15.0 , left: 15.0 ,top: 15.0),
                    child: Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyWallet(
                              user: user,
                            ),
                          ));
                        },
                        leading: Icon(
                          Icons.account_balance_wallet,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "My Wallet",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          widget.navigateFromDrawerToCart();
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "My Cart",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          widget.navigateFromDrawerToCategories();
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          Icons.category,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Categories",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          widget.navigateFromDrawerToOffers();
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          Icons.local_offer,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Offers",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReferAndEarn(uid: uid, user:  user,),
                          ));
                        },
                        leading: Icon(
                          Icons.local_activity,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Refer and Earn",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
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
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Gift Card",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0 , bottom: 2.0),
                    child: Container(
                      height: 40.0,
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
                          Icons.assignment,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "My Order",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: 15.0 , left: 15.0 , top:15.0),
                    child: Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactUs(),
                          ));
                        },
                        leading: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "Contact Us",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FAQs(),
                          ));
                        },
                        leading: Icon(
                          Icons.help,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          "FAQ's",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                    child: Container(
                      height: 40.0,
                      child: ListTile(
                        onTap: () {
                          userLogged ? FirebaseAuth.instance.signOut() : Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                          userLogged ? setState((){userLogged = false;}) : null;
                        },
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        leading: Icon(
                          userLogged ? MdiIcons.logout : MdiIcons.login,
                          color: Theme.of(context).primaryColor,
                          size: width * 0.065,
                        ),
                        title: Text(
                          userLogged ? "Log Out" : "Log In",
                          style: GoogleFonts.openSans(
                            fontSize: height * 0.028,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
