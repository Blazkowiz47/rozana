import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:rozana/model/models.dart';
import 'package:social_share/social_share.dart';

class ReferAndEarn extends StatefulWidget {
  final String uid;
  final UserModel user;
  ReferAndEarn({this.uid , this.user});
  @override
  _ReferAndEarnState createState() => _ReferAndEarnState();
}


class _ReferAndEarnState extends State<ReferAndEarn> {
  String code;
  String currrentBalance;
  String referralcode;
  void getReferralCode(){
    setState(() {
      code = randomAlphaNumeric(7);
    });
  }
  @override
  void initState() {
    getReferralCode();
    if(widget.uid != null){
      setState(() {
        currrentBalance = widget.user.walletBalance;
      });
    }
    super.initState();
  }
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
          "Refer And Earn",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height*0.37,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/refer.png"),
                    fit: BoxFit.none,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width*0.4,
                      height: height*0.08,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.0),
                        child: Center(
                          child: Text(
                            code,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                      ),
                    ),
                    Container(
                      width: width*0.2,
                      height: height*0.08,
                      color: Colors.red[700],
                      child: Center(
                        child: Text(
                          "Copy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width*0.1 , top: 10.0 , bottom: 5.0),
                child: Container(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Send via",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          FlutterShareMe().shareToWhatsApp(msg: "Refer Code : $code");
                        }catch(w){
                          print(w);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/whatsapp.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          SocialShare.shareInstagramStory("images/refer.png", "#FFFFFF", "#FFFFFF"," https://deep-link-url");
                        }catch(w){
                          print(w);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/insta.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          SocialShare.shareFacebookStory("images/refer.png", "#FFFFFF", "#FFFFFF"," https://deep-link-url");
                        }catch(w){
                          print(w);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/fb.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/linkedin.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          SocialShare.shareSms("Refer Code: $code");
                        }catch(w){
                          print(w);
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/thundermail.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          SocialShare.shareTwitter("Refer Code: $code");
                        }catch(w){
                          print(w);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/twitter.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        try{
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          SocialShare.shareTelegram("Refer Code: $code");
                        }catch(w){
                          print(w);
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/telegram.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 10.0),
                child: Container(
                  width: width*0.7,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(height*0.035)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      getReferralCode();
                    },
                    child: Text(
                      "Get Referral Code",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: height * 0.032,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width*0.1 , top: 20.0 , bottom: 5.0),
                child: Container(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Already got a referral code??",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.1 , vertical: 20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    onChanged: (val){
                      setState(() {
                        val = referralcode;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter code here",
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 10.0 , bottom: 50.0 , left: width*0.3 , right: width*0.3,),
                child: Container(
                  width: width*0.7,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(height*0.035)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      try{
                        if(referralcode.length == 7){
                          Firestore.instance.collection('user').document(widget.uid).updateData({
                            "WalletBalance" : (double.parse(currrentBalance)+ 10.0).toString(),
                          });
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return AlertDialog(title: Text("Success"),content: Text("Rs. 10 have been added to your wallet."),actions: <Widget>[
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
                      }catch(w){
                        print(w);
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return AlertDialog(title: Text("Error"),content: Text("Invalid Referral code"),actions: <Widget>[
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
                      "Claim",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: height * 0.032,
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
