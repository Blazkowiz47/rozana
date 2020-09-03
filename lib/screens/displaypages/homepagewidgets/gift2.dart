import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class GiftCards2 extends StatefulWidget {
  final double amount;
  final String rname;
  final String message;
  final String phone;
  final String email;
  final String name;
  final File image;
  GiftCards2({ this.image ,  this.amount, this.rname, this.message, this.phone, this.email, this.name});
  @override
  _GiftCards2State createState() => _GiftCards2State();
}

class _GiftCards2State extends State<GiftCards2> {
  Razorpay _razorpay;
  bool loading = false;
  void gotoCOD() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
  void gotocomptrans() async {
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
      'amount' : widget.amount, //in paise so * 100
      'name': widget.name,
      'currency' : "INR",
      'description': 'Check Out',
      'prefill': {'contact': widget.phone, 'email': widget.email},
//      'prefill.method' : 'upi',
      //'theme.hide_topbar' : 'true', // It can be card/netbanking/wallet/emi/upi. However, it will only work if contact and email are also pre-filled.
    };
    try {
      print('Going to try');
      _razorpay.open(options);
      print('try done');
    } catch (e) {
      debugPrint(e);
      Future.delayed(Duration(milliseconds: 5000) , (){
        showDialog(context: context , builder: (BuildContext context){
          return AlertDialog(
            title: Text("Error"),
            content: Text("Transaction Failed Check Mobile Number"),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      });
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    return gotocomptrans();
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    Future.delayed(Duration(milliseconds: 5000) , (){
      showDialog(context: context , builder: (BuildContext context){
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
        centerTitle: true,
        title: Text(
          "Preview Your Gift Cards",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: Text(
                "Reciepient's Email Address",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: Text(
                "${widget.email}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: Text(
                "Reciepient's Phone Number",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: Text(
                "${widget.phone}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width *0.05 ,vertical: 10.0 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height*0.27,
                    width: width*0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.rname}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "${widget.message}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "From ${widget.name}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.image == null ? AssetImage("images/gift.png") : FileImage(widget.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    "Rs. ${(widget.amount/100).round()}",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
              child: Text(
                "Expiry Date | 1 Year From Today",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: GestureDetector(
                onTap: (){
                  openCheckout();
                },
                child: Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Center(
                      child: Text(
                        "Proceed to Pay",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
