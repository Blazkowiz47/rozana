import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/displaypages/fundwallet.dart';

class MyWallet extends StatelessWidget {
  final UserModel user;
  MyWallet({this.user});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "My Wallet",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Image.asset("images/mywalletpage.png"),
                title: Text(
                  "Wallet Summary",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                subtitle: Text(
                  "Current Balance is Rs.${user.walletBalance}",
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0),
              child: FlatButton(
                color: Colors.black26,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder : (context) => FundWallet(user: user,),
                  ));
                },
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.3, vertical: 17.0),
                  child: Text(
                    "Fund Wallet",
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
              child: Text(
                "Wallet Activity For",
                style: TextStyle(
                    fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(
                "July 2019 ",
                style: TextStyle(
                    fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
              child: Text(
                "June 2019",
                style: TextStyle(
                    fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:10, vertical: 5.0),
              child: Text(
                "May 2019",
                style: TextStyle(
                    fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
