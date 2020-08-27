import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/payment/cod.dart';
import 'tansactiondone.dart';

class Payment extends StatefulWidget {
  final double total;
  final double originalTotal;
  final double savings;
  final String phone;
  final String email;
  final String name;
  Payment({this.total,this.originalTotal,this.savings,this.email,this.name, this.phone});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int select;
  Razorpay _razorpay;
  double sumInPaise ;
  void gotoCOD() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
  void gotocomptrans() async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection('user').document(user.uid).get().then((ds) async {
        List<CartItems> cart = List<CartItems>();
        print("Transferring LIst");
        ds.data["Cart"].forEach((item) {
          print("Transferring Started");
          if(item["IsOffer"]){
            print("Transferring Offer");
            cart.add(CartItems(productId: item["ProductId"] , isOffer: true , offer: OffersModel.fromJson(jsonDecode(item["Offer"])) ));
            print("Transfer complete");
          }
          else{
            print("Transferring Product");
            cart.add(CartItems(index: item["Index"] , productId: item["ProductId"] , isOffer: false , product: Product.fromJson(jsonDecode(item["Product"])) ));
            print("Add complete");
          }
        });
        print("MyOrders");
        print(ds.data["MyOrders"]);
        print(ds.data["MyOrders"].length);
        int length = ds.data["MyOrders"] == [] ? 0 : ds.data["MyOrders"].length;
//        print(ds.data["MyOrders"][0]);
        print("----");
        List myOrders = List();
        print("----");
        for (int i = 0 ; i < length ; i++){
          print("----");
          myOrders.add(ds.data["MyOrders"][i]);
          print("----");
        }
        print("__________________________________");
        print(myOrders);
        print("__________________________________");
        myOrders.add(cart.map((e) {
          if(e.isOffer){
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Offer" : jsonEncode(e.offer.toJson()),
              "Booked" : true,
            };
          }
          else{
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Index" : e.index,
              "Product" : jsonEncode(e.product.toJson()),
              "Booked" : true,
            };
          }
        }).toList()
        );
        await Firestore.instance.collection('user').document(user.uid).updateData({
          "MyOrders" : myOrders,
          "Cart" : [],
        });
      });
    });
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DonePage()));
  }
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    select = 0;
    sumInPaise = widget.total;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key' : 'rzp_live_5ChABNIpDL5RRj',
      'amount' : sumInPaise, //in paise so * 100
      'name': "ROZANA",
      'description': 'Check Out',
      'prefill': {'contact': 7080855524, 'email': "cs@cwservices.co.in"},
      'external': {
        'wallets': ['paytm' , 'phonepe' , 'amazonpay']
      }
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
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
        toolbarHeight: height*0.13,
        elevation: 0.0,
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          overflow: Overflow.clip,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Total Value",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       "\u20B9 ${widget.originalTotal}",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Delivery",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       "\u20B9 50",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 15.0 ),
                   child: Divider(
                     height: 2.0,
                     thickness: 1.0,
                     color: Colors.black87,
                   ),
                 ),
                 Text(
                   "Apply Voucher",
                   textAlign: TextAlign.left,
                   style:TextStyle(
                     color: Colors.red[900],
                     fontSize: 20.0 ,
                     fontWeight: FontWeight.w700,
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Total Amount Payable",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       "\u20B9 ${50.0 + widget.total/100}",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 15.0),
                   child: Divider(
                     height: 2.0,
                     thickness: 1.0,
                     color: Colors.black87,
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Your Total Saving",
                       style:TextStyle(
                         color: Colors.green,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       "\u20B9 ${widget.savings}",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 20.0 ,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 15.0),
                   child: Divider(
                     height: 2.0,
                     thickness: 1.0,
                     color: Colors.black87,
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 10.0),
                   child: Text(
                     "Payment Options with Offers",
                     style:TextStyle(
                       color: Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
                 ListTile(
                   dense: true,
                   leading: Image.asset("images/paytm.png"),
                   title: Text(
                     "Paytm",
                     style:TextStyle(
                       color: select == 1 ? Colors.green : Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   trailing: IconButton(
                     onPressed: (){
                       setState(() {
                         select = 1;
                       });
                     },
                     icon: Icon(select == 1 ? Icons.check_box : Icons.check_box_outline_blank),
                   ),
                 ),
                 ListTile(
                   dense: true,
                   leading: Image.asset("images/gpay.png"),
                   title: Text(
                     "Google Pay",
                     style:TextStyle(
                       color: select == 2 ? Colors.green : Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   trailing: IconButton(
                     onPressed: (){
                       setState(() {
                         select = 2;
                       });
                     },
                     icon: Icon(select == 2 ? Icons.check_box : Icons.check_box_outline_blank),
                   ),
                 ),
                 ListTile(
                   dense: true,
                   leading: Image.asset("images/cash.png"),
                   title: Text(
                     "Cash On Delivery",
                     style:TextStyle(
                       color: select == 3 ? Colors.green : Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   trailing: IconButton(
                     onPressed: (){
                       setState(() {
                         select = 3;
                       });
                     },
                     icon: Icon(select == 3 ? Icons.check_box : Icons.check_box_outline_blank),
                   ),
                 ),
                 ListTile(
                   dense: true,
                   leading: Image.asset("images/upi.png"),
                   title: Text(
                     "UPI",
                     style:TextStyle(
                       color: select == 4 ? Colors.green : Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   trailing: IconButton(
                     onPressed: (){
                       setState(() {
                         select = 4;
                       });
                     },
                     icon: Icon(select == 4 ? Icons.check_box : Icons.check_box_outline_blank),
                   ),
                 ),
                 ListTile(
                   dense: true,
                   leading: Image.asset("images/card.png"),
                   title: Text(
                     "Credit or debit card",
                     style:TextStyle(
                       color: select == 5 ? Colors.green : Colors.black,
                       fontSize: 20.0 ,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   trailing: IconButton(
                     onPressed: (){
                       setState(() {
                         select = 5;
                       });
                     },
                     icon: Icon(select == 5 ? Icons.check_box : Icons.check_box_outline_blank),
                   ),
                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image.asset("images/paytm.png"),
//                     SizedBox(width: 20.0,),
//                     GestureDetector(
//                       onTap: (){
//                         setState(() {
//                           select = 1;
//                         });
//                         print(select);
//                       },
//                       child: Text(
//                         "Paytm",
//                         style:TextStyle(
//                           color: select == 1 ? Colors.green : Colors.black,
//                           fontSize: 20.0 ,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image.asset("images/gpay.png"),
//                     SizedBox(width: 20.0,),
//
//                     Text(
//                       "Google Pay",
//                       style:TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0 ,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: height*0.07,
//                       width: width*0.1,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("images/cash.png"),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20.0,),
//
//                     Text(
//                       "Cash On Delivery",
//                       style:TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0 ,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image.asset("images/upi.png"),
//                     SizedBox(width: 20.0,),
//
//                     Text(
//                       "UPI",
//                       style:TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0 ,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image.asset("images/card.png"),
//                     SizedBox(width: 20.0,),
//                     Text(
//                       "Credit or debit card",
//                       style:TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0 ,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
               ],
              ),
            ),
            Positioned(
              bottom: -7.0,
              child: Container(
                width: width,
                height: height*0.12,
//                clipBehavior: Clip.antiAlias,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.green,

                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "\u20B9 ${50.0+widget.total/100 }",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          //Process paymemnt
                          if(select != 3){
                            try{
                              openCheckout();
                            }catch(e){
                              final snackBar = SnackBar(
                                content: Text('There Was some Error'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          }
                          else{
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CodPage(widget.total/100),
                            ));
                          }
                        },
                        child: Container(
                          width: width*0.35,
                          height: height*0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(height*0.035)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Buy Now",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
