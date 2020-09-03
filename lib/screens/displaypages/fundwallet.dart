import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/payment/cod.dart';
import 'package:rozana/screens/payment/tansactiondone.dart';

class FundWallet extends StatefulWidget {
  UserModel user;
  FundWallet({this.user});
  @override
  _FundWalletState createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  int select;
  Razorpay _razorpay;
  double sumInPaise ;
  bool loading = false;
  void gotoCOD() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
  void gotocomptrans() async {
    FirebaseAuth.instance.currentUser().then((uid) {
      if(uid == null){
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
      Firestore.instance.collection('user').document(uid.uid).updateData({
        "WalletBalance" : (double.parse(widget.user.walletBalance) + sumInPaise/100).toString(),
      });
    });
    setState(() {
      loading = false;
    });
    Future.delayed(Duration(milliseconds: 5000) , (){
      showDialog(context: context , builder: (BuildContext context){
        return AlertDialog(
          title: Text("Success"),
          content: Text("Transaction Completed"),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      });
    });
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    select = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    setState(() {
      loading = true;
    });
    var options = {
      'key' : 'rzp_live_5ChABNIpDL5RRj',
      'amount' : sumInPaise, //in paise so * 100
      'name': "ROZANA",
      'currency' : "INR",
      'description': 'Check Out',
      'prefill': {'contact': 7080855524, 'email': "cs@cwservices.co.in"},
//      'prefill.method' : 'upi',
      //'theme.hide_topbar' : 'true', // It can be card/netbanking/wallet/emi/upi. However, it will only work if contact and email are also pre-filled.
    };
    try {
      print('Going to try');
      _razorpay.open(options);
      print('try done');
    } catch (e) {
      debugPrint(e);
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    return gotocomptrans();
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    Future.delayed(Duration(milliseconds: 5000) , (){
      showDialog(context: context , builder: (BuildContext context){
        print("-----------------------------");
        print(response.message);
        print("-----------------------------");
        return AlertDialog(
          title: Text("Error"),
          content: Text("Transaction Failed"),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      });
    });
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fund Wallet",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
        toolbarHeight: height*0.13,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (val){
                setState(() {
                  sumInPaise = double.parse(val)*100;
                });
              },
              decoration: InputDecoration(
                hintText: "Amount",
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              color: Colors.black26,
              onPressed: (){
                if(sumInPaise != null){
                  openCheckout();
                }
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:10, vertical: 17.0),
                child: Text(
                  "Credit, Debit, Net Banking, UPI",
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
