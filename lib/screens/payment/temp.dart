//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import './cod.dart';
//import './tansactiondone.dart';
//
//
//class PaymentPage extends StatefulWidget {
//  double sum;
//  PaymentPage(this.sum );
//  @override
//  _PaymentPageState createState() => _PaymentPageState();
//}
//
//class _PaymentPageState extends State<PaymentPage> {
//
//  void gotoCOD() {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => CodPage(widget.sum)));
//  }
//  void gotocomptrans(int val) async {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => DonePage(val)));
//  }
//  @override
//  void initState() {
//    _razorpay = Razorpay();
//    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//    super.initState();
//    select = 0;
//    sumInPaise = widget.sum * 100;
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _razorpay.clear();
//  }
//
//  void openCheckout() async {
//    var options = {
//      'key' : 'rzp_test_Fs6iRWL4ppk5ng',
//      'amount' :sumInPaise, //in paise so * 100
//      'name': 'Rtiggers',
//      'description': 'Fine Food',
//      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//      'prefill.method' : 'upi',
//      //'theme.hide_topbar' : 'true', // It can be card/netbanking/wallet/emi/upi. However, it will only work if contact and email are also pre-filled.
//    };
//    try {
//      print('Going to try');
//      await _razorpay.open(options);
//      print('tryy done');
//    } catch (e) {
//      debugPrint(e);
//    }
//  }
//  void _handlePaymentSuccess(PaymentSuccessResponse response) {
//    return gotocomptrans(select);
//  }
//  void _handlePaymentError(PaymentFailureResponse response) {
//    return _showDialog(context);
//  }
//  void _handleExternalWallet(ExternalWalletResponse response) {
//  }
//  Image appLogo = Image(
//
//    image: new ExactAssetImage('images/dw.png'),
//    height: 75,
//    width: 75,
//  );
//  Image pLogo = Image(
//
//    image: new ExactAssetImage('images/GPAY.png'),
//    height: 70.0,
//    width: 70.0,
//  );
//  Image eLogo = Image(
//
//    image: new ExactAssetImage('images/PAYTM.png'),
//    height: 70.0,
//    width: 70.0,
//  );
//  Image uLogo = Image(
//
//    image: new ExactAssetImage('images/upi.png'),
//    height: 75.0,
//    width: 75.0,
//  );
//  Image emiLogo = Image(
//
//    image: new ExactAssetImage('images/ul.png'),
//    height: 75.0,
//    width: 75.0,
//  );
//  Image netLogo = Image(
//
//    image: new ExactAssetImage('images/ol.png'),
//    height: 75.0,
//    width: 75.0,
//  );
//  Image cashLogo = Image(
//    image: ExactAssetImage('images/Cash.png'),
//
//    height: 60.0,
//    width: 60.0,
//  );
//  @override
//  Widget build(BuildContext context) {
//    double x = MediaQuery.of(context).size.width;
//    double y = MediaQuery.of(context).size.height;
//    return Scaffold(
//        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
//        appBar: AppBar(
//          leading: IconButton(
//              color: Colors.white,
//              icon: Icon(Icons.arrow_back),
//              onPressed: () {
//                Navigator.of(context).pop();
//              }),
//          backgroundColor: Color.fromRGBO(00, 44, 64, 1.0),
//          elevation: 0.0,
//          automaticallyImplyLeading: false,
//          centerTitle: true,
//          title: Text(
//            "Payment",
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: MediaQuery.of(context).size.height*0.025,
//            ),
//          ),
//        ),
//        body: Stack(children: <Widget>[
//          ListView(
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.06, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: [
//                      ListTile(
//                        leading: appLogo,
//                        title: Text('Credit Card'),
//                        onTap: () {
//                          setState(() {
//                            select = 1;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 1,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: pLogo,
//                        title: Text('Google Pay'),
//                        onTap: () {
//                          setState(() {
//                            select = 2;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 2,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: eLogo,
//                        title: Text('PayTm Payment'),
//                        onTap: () {
//                          setState(() {
//                            select = 3;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 3,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: uLogo,
//                        title: Text('UPI Payment'),
//                        onTap: () {
//                          setState(() {
//                            select = 4;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 4,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: emiLogo,
//                        title: Text('PhonePe'),
//                        onTap: () {
//                          setState(() {
//                            select = 5;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 5,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: netLogo,
//                        title: Text('Debit Card'),
//                        onTap: () {
//                          setState(() {
//                            select = 6;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 6,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    top: y * 0.03, left: x * 0.08, right: x * 0.08),
//                child: Container(
//                  decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            blurRadius: 3,
//                            color: Colors.grey,
//                            offset: Offset(0, 2))
//                      ],
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Stack(
//                    children: <Widget>[
//                      ListTile(
//                        leading: cashLogo,
//                        title: Text('Cash On Delivery'),
//                        onTap: () {
//                          setState(() {
//                            select = 7;
//                          });
//                        },
//                      ),
//                      Positioned(
//                        bottom: 5,
//                        right: 0,
//                        child: Radio(
//                            value: 7,
//                            groupValue: select,
//                            onChanged: (value) {
//                              setState(() {
//                                select = value;
//                              });
//                            }),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(height: y * 0.02),
//              Padding(
//                padding: EdgeInsets.symmetric(
//                    vertical: y * 0.03, horizontal: x * 0.2),
//                child: SizedBox(
//                  width: x * 0.1,
//                  height: y * 0.08,
//                  child: RaisedButton(
//                    onPressed: () {
//                      if (select == 7) {
//                        print(widget.sum);
//                        Meals_list_ordered.removeWhere(
//                                (e) => e['mode'] == null);
//
//                        Meals_list_ordered.add({
//                          'id': 'Order ${Meals_list_ordered.length + 1}',
//                          'loc': 'images/pp.png',
//                          'status': 'ordered',
//                          'amount': widget.sum,
//                          'mode': select,
//                        });
//
//                        gotoCOD();
//                      }
//                      if (select == 1 ||
//                          select == 2 ||
//                          select == 3 ||
//                          select == 4 ||
//                          select == 5 ||
//                          select == 6) {
//                        openCheckout();
//                        print(widget.sum);
//                        Meals_list_ordered.removeWhere(
//                                (e) => e['mode'] == null);
//                        Meals_list_ordered.add(
//                          {
//                            'id': 'Order ${Meals_list_ordered.length + 1}',
//                            'loc': 'images/pp.png',
//                            'status': 'ordered',
//                            'amount': widget.sum,
//                            'mode': select,
//                          },
//                        );
//                        saltot = 0;
//                        tot = 0;
//                        //gotocomptrans(select);
//                      }
//                    },
//                    child: Text("Payment",
//                        style: TextStyle(
//                          //fontWeight: FontWeight.bold,
//                          color: Colors.white,
//                          fontSize: MediaQuery.of(context).size.height*0.02,
//                        )),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(50.0),
//                        side: BorderSide(
//                          color: Color.fromRGBO(00, 44, 64, 1.0),
//                        )),
//                    color: Color.fromRGBO(00, 44, 64, 1.0),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ]));
//  }
//  void _showDialog(context) {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: Text("Payment Failed"),
//          content: Text("Please try again"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            FlatButton(
//              child: Text("Close"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//}
//
//
