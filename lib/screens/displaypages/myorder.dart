import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/authenticate/authenticate.dart';
import 'package:rozana/screens/feedback.dart';
import 'package:rozana/screens/track.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Hexcolor("#F2F1F1"),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "My Orders",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
//      body: Column(
//        children: [
//          Padding(
//            padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: 10.0),
//            child: Container(
//              height: height*0.17,
//              width: width,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//              ),
//              child: Row(
//                children: [
//                  Padding(
//                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
//                    child: Container(
//                      height: height*0.175,
//                      width: width*0.27,
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                          image: AssetImage("images/oeder.png"),
//                          fit: BoxFit.contain,
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
//                    child: Container(
//                      height: height*0.175,
//                      width: width*0.27,
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Padding(
//                            padding: const EdgeInsets.symmetric(vertical: 2.50),
//                            child: Text(
//                              "Product",
//                              style: TextStyle(
//                                fontSize: 16.0,
//                              ),
//                            ),
//                          ),
//                          Text(
//                            "Product",
//                            style: TextStyle(
//                              fontSize: 16.0,
//                            ),
//                          ),
//                          Padding(
//                            padding:const EdgeInsets.symmetric(vertical: 2.50),
//                            child: Text(
//                              "Product",
//                              style: TextStyle(
//                                fontSize: 16.0,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  SizedBox(width: 10.0,),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      GestureDetector(
//                        onTap: (){},
//                        child: Padding(
//                          padding: const EdgeInsets.only(bottom: 10.0),
//                          child: Container(
//                            height: height*0.05,
//                            width: width*0.22,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                            ),
//                            child: Center(
//                              child: Text("Cancel Order"),
//                            ),
//                          ),
//                        ),
//                      ),
//                      GestureDetector(
//                        onTap: (){},
//                        child: Container(
//                          height: height*0.05,
//                          width: width*0.22,
//                          decoration: BoxDecoration(
//                            color: Colors.red[900],
//                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                          ),
//                          child: Center(
//                            child: Text("Track Order",style: TextStyle(color: Colors.white),),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
      body: StreamBuilder<FirebaseUser>(
          stream: AuthService().userStream,
          builder: (context, user) {
            if(user.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            else if(user.connectionState == ConnectionState.none){
              return CircularProgressIndicator();
            }
            else{
              String uid;
              if(user.hasData){
                uid = user.data.uid;
              }
              return !user.hasData
                  ? Center(
                child: Text(
                  "Please Sign in First",
                  style: TextStyle(fontSize: 22.0),
                ),
              )
                  : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height,
                      width: width,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection("user")
                            .document(uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            {return CircularProgressIndicator();}
                          }
                          else {
                            print("got error");
                            List cart = snapshot.data["Cart"];
                            print("got error");
                            print(cart);
                            //                      List<CartItems> offerItems = List<CartItems>();
//                        List<CartItems> normalItems = List<CartItems>();
                            if(cart.length != 0) {
                              print(cart.length);
                              print("List");
                              print(cart.length);
                              double total = 0.0;
                              double tax = 0.0;
                              double savings = 0.0;
                              double originalTotal = 0.0;
                              List<CartItems> list = List<CartItems>();
                              for (int i = 0; i < cart.length; i++) {
                                if (cart[i]["IsOffer"] && cart[i]["Booked"]) {
                                  list.add(CartItems(
                                    Booked: cart[i]["Booked"],
                                    isOffer: cart[i]["IsOffer"],
                                    productId: cart[i]["ProductId"],
                                    delivered: cart[i]["Delivered"],
                                    offer: OffersModel.fromJson(
                                      jsonDecode(cart[i]["Offer"]),
                                    ),
                                  ));
//                                Firestore.instance.collection("offers").document(cart[i]["ProductId"]).get().then((document) {
//                                  offersProducts.add(
//                                    OffersModel(
//                                      id: document.documentID,
//                                      name: document.data["Name"],
//                                      category: document.data["Category"].join(" ").toString(),
//                                      imageUrl: document.data["ImageUrl"],
//                                      quantity: document.data["Quantity"],
//                                      mrp: document.data["Mrp"],
//                                      offerPercent: document.data["OfferPercent"],
//                                      tax: document.data["Tax"],
//                                    ),
//                                  );
//                                  list.add(CartItemList(
//                                    offer: OffersModel(
//                                      id: document.documentID,
//                                      name: document.data["Name"],
//                                      category: document.data["Category"].join(" ").toString(),
//                                      imageUrl: document.data["ImageUrl"],
//                                      quantity: document.data["Quantity"],
//                                      mrp: document.data["Mrp"],
//                                      offerPercent: document.data["OfferPercent"],
//                                      tax: document.data["Tax"],
//                                    ),
//                                    height: height,
//                                    width: width,
//                                  ));
//                                });
                                }
                                else {
                                  !cart[i]["Booked"] ? null : list.add(CartItems(
                                    Booked: cart[i]["Booked"],
                                    isOffer: cart[i]["IsOffer"],
                                    productId: cart[i]["ProductId"],
                                    index: cart[i]["Index"],
                                    delivered: cart[i]["Delivered"],
                                    product: Product.fromJson(
                                      jsonDecode(cart[i]["Product"]),
                                    ),
                                  ));
//                                Firestore.instance.collection("normalProducts").document(cart[i]["ProductId"]).get().then((doc){
//                                  DifferentItems differentItems = DifferentItems(
//                                    mrp: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["Mrp"],
//                                    discount: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["Discount"],
//                                    imageUrl: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["ImageUrl"],
//                                    quantity: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["Quantity"],
//                                    quantityInStock: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["QuantityInStock"],
//                                    tentativeNewStockArrivalDate: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["TentativeNewStockArrivalDate"],
//                                    tax: doc.data["DifferentSizes"][int.parse(cart[i]["Index"])]["Tax"],
//                                  );
//                                  normalProducts.add(Product(
//                                    id: doc.documentID,
//                                    name: doc.data["Name"],
//                                    addedOn: doc.data["AddedOn"],
//                                    category: doc.data["Category"].join(" ").toString(),
//                                    brand: doc.data["Brand"],
//                                    items: [differentItems],
//                                  ));
//                                  list.add(
//                                    ItemList(
//                                      product: Product(
//                                        id: doc.documentID,
//                                        name: doc.data["Name"],
//                                        addedOn: doc.data["AddedOn"],
//                                        category: doc.data["Category"].join(" ").toString(),
//                                        brand: doc.data["Brand"],
//                                        items: [differentItems],
//                                      ),
//                                      height: height,
//                                      width: width,
//                                    ),
//                                  );
//                                });
                                }
                              }
                              print(list);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          if(list[index].isOffer && !list[index].delivered){
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: 10.0),
                                              child: Container(
                                                height: height*0.17,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                      child: Container(
                                                        height: height*0.175,
                                                        width: width*0.27,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage("images/oeder.png"),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                      child: Container(
                                                        height: height*0.175,
                                                        width: width*0.27,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 2.50),
                                                              child: Text(
                                                                list[index].offer.name,
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              list[index].offer.mrp,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:const EdgeInsets.symmetric(vertical: 2.50),
                                                              child: Text(
                                                                "Delivery Date",
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: ()async{
                                                            FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                                            UserDatabaseService(user:user).removeItem( isOffer: list[index].isOffer , productId: list[index].isOffer ? list[index].offer.id : list[index].product.id.trim() , index: list[index].isOffer ? null : list[index].index.toString().trim());
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 10.0),
                                                            child: Container(
                                                              height: height*0.05,
                                                              width: width*0.22,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => Track()));
                                                          },
                                                          child: Container(
                                                            height: height*0.05,
                                                            width: width*0.22,
                                                            decoration: BoxDecoration(
                                                              color: Colors.red[900],
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            ),
                                                            child: Center(
                                                              child: Text("Track Order",style: TextStyle(color: Colors.white),),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          return !list[index].delivered ?  Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: 10.0),
                                            child: Container(
                                              height: height*0.17,
                                              width: width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                    child: Container(
                                                      height: height*0.175,
                                                      width: width*0.27,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage("images/oeder.png"),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                    child: Container(
                                                      height: height*0.175,
                                                      width: width*0.27,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2.50),
                                                            child: Text(
                                                              list[index].product.name,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            list[index].product.items[int.parse(list[index].index)].mrp,
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:const EdgeInsets.symmetric(vertical: 2.50),
                                                            child: Text(
                                                              "Delivery Date",
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.0,),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: ()async{
                                                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                                          UserDatabaseService(user:user).removeItem( isOffer: list[index].isOffer , productId: list[index].isOffer ? list[index].offer.id : list[index].product.id.trim() , index: list[index].isOffer ? null : list[index].index.toString().trim());
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(bottom: 10.0),
                                                          child: Container(
                                                            height: height*0.05,
                                                            width: width*0.22,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order"),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => Track()));
                                                        },
                                                        child: Container(
                                                          height: height*0.05,
                                                          width: width*0.22,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red[900],
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                          ),
                                                          child: Center(
                                                            child: Text("Track Order",style: TextStyle(color: Colors.white),),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) : Container();
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          if(list[index].isOffer && list[index].delivered){
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: 10.0),
                                              child: Container(
                                                height: height*0.17,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                      child: Container(
                                                        height: height*0.175,
                                                        width: width*0.27,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage("images/oeder.png"),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                      child: Container(
                                                        height: height*0.175,
                                                        width: width*0.27,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 2.50),
                                                              child: Text(
                                                                list[index].offer.name,
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              list[index].offer.mrp,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:const EdgeInsets.symmetric(vertical: 2.50),
                                                              child: Text(
                                                                "Delivery Date",
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){},
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 10.0),
                                                            child: Container(
                                                              height: height*0.05,
                                                              width: width*0.22,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => FeedBack()));
                                                          },
                                                          child: Container(
                                                            height: height*0.05,
                                                            width: width*0.22,
                                                            decoration: BoxDecoration(
                                                              color: Colors.red[900],
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            ),
                                                            child: Center(
                                                              child: Text("Give Feed Back",style: TextStyle(color: Colors.white),),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          return list[index].delivered ?  Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: 10.0),
                                            child: Container(
                                              height: height*0.17,
                                              width: width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                    child: Container(
                                                      height: height*0.175,
                                                      width: width*0.27,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage("images/oeder.png"),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:  EdgeInsets.symmetric(vertical: height*0.01 , horizontal: 10.0),
                                                    child: Container(
                                                      height: height*0.175,
                                                      width: width*0.27,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2.50),
                                                            child: Text(
                                                              list[index].product.name,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            list[index].product.items[int.parse(list[index].index)].mrp,
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:const EdgeInsets.symmetric(vertical: 2.50),
                                                            child: Text(
                                                              "Delivery Date",
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.0,),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){},
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(bottom: 10.0),
                                                          child: Container(
                                                            height: height*0.05,
                                                            width: width*0.22,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order"),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => FeedBack(),
                                                          ));
                                                        },
                                                        child: Container(
                                                          height: height*0.05,
                                                          width: width*0.22,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red[900],
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                          ),
                                                          child: Center(
                                                            child: Text("Give Feed Back",style: TextStyle(color: Colors.white),),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) : Container();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Center(
                              child: Container(
                                height: height*0.9,
                                width: width*0.8,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: height*0.5,
                                      width: width*0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: AssetImage("images/empty.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 10.0),
                                      child: Container(
                                        width: width*0.7,
                                        height: height*0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Your Order is Empty",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 22.0
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 10.0),
                                        child: Container(
                                          width: width*0.7,
                                          height: height*0.1,
                                          decoration: BoxDecoration(
                                            color: Hexcolor("#6BC65A"),
                                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "View Order Details",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.0
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );}
          }),
    );
    return Scaffold(

    );
  }
}
