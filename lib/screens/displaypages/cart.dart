import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/authenticate/authenticate.dart';
import 'file:///D:/APPD/rozana/lib/screens/payment/payment.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<FirebaseUser>(
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
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        UserDatabaseService(user: user).clearCart();
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.05, top: 10.0, bottom: 10.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
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
                        // List<CartItems> offerItems = List<CartItems>();
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
                        int count = 0;
                        for(int i = 0 ; i < cart.length ; i++){
                          if(!cart[i]["Booked"])
                            count+=1;
                        }
                        if(count == 0){
                          return Center(child: Text("Please shop"  , style: TextStyle(color: Colors.black54 , fontSize:  22.0),),);
                        }
                        for (int i = 0; i < cart.length; i++) {
                          if (cart[i]["IsOffer"] && !cart[i]["Booked"]) {
                            list.add(CartItems(
                              Booked: cart[i]["Booked"],
                              isOffer: cart[i]["IsOffer"],
                              productId: cart[i]["ProductId"],
                              noOfItems: cart[i]["NoOfItems"],
                              offer: OffersModel.fromJson(jsonDecode(cart[i]["Offer"])),
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
                            cart[i]["Booked"] ? null : list.add(CartItems(
                              Booked: cart[i]["Booked"],
                              isOffer: cart[i]["IsOffer"],
                              productId: cart[i]["ProductId"],
                              index: cart[i]["Index"],
                              product: Product.fromJson(jsonDecode(cart[i]["Product"])),
                              noOfItems: cart[i]["NoOfItems"],
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
                        list.add(CartItems());
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            if(index == list.length -1){
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Sub total" , style: TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                          Text("\u20B9 $total" , style: TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tax" , style: TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                          Text("\u20B9 $tax", style: TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total",style:TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                          Text("\u20B9 ${(tax+total)}" , style:TextStyle(color: Colors.black38,fontSize: 20.0 , fontWeight: FontWeight.w500,),),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical : 20.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => Payment(
                                                  total: (tax+total)*100,
                                                  originalTotal: originalTotal,
                                                  savings: savings,
                                                  name: snapshot.data["FirstName"] + snapshot.data["LastName"],
                                                  phone: "+91"+snapshot.data["PhoneNumber"],
                                                  email: snapshot.data["EmailID"],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: height*0.08,
                                            width: width*0.8,
                                            child: Center(
                                              child: Text(
                                                "Checkout",
                                                style:TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0 ,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height*0.3,),
                                    ],
                                  ),
                                ),
                              );
                            }

                            if(list[index].isOffer){
                                total +=list[index].noOfItems *double.parse(list[index].offer.mrp) * (1 - double.parse(list[index].offer.offerPercent)/100);
                                tax += list[index].noOfItems * double.parse(list[index].offer.mrp) * (double.parse(list[index].offer.tax)/100);
                                savings += list[index].noOfItems * double.parse(list[index].offer.mrp) * (double.parse(list[index].offer.offerPercent)/100);
                                originalTotal += list[index].noOfItems * double.parse(list[index].offer.mrp);
                                print(total);
                                print(tax);
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                child: CartItemList(
                                  height: height,
                                  width: width,
                                  user: user.data,
                                  productId: list[index].productId,
                                  noOfItems: list[index].noOfItems,
                                  isOffer: list[index].isOffer,
                                  offer: list[index].offer,
                                ),
                              );
                            }

                              total +=list[index].noOfItems * double.parse(list[index].product.items[int.parse(list[index].index)].mrp) * (1 - double.parse(list[index].product.items[int.parse(list[index].index)].discount)/100);
                              tax +=list[index].noOfItems * double.parse(list[index].product.items[ int.parse(list[index].index) ].mrp) * (double.parse(list[index].product.items[int.parse(list[index].index)].tax)/100);
                              savings +=list[index].noOfItems * double.parse(list[index].product.items[int.parse(list[index].index)].mrp) * (double.parse(list[index].product.items[int.parse(list[index].index)].discount)/100);
                              originalTotal += list[index].noOfItems *double.parse(list[index].product.items[int.parse(list[index].index)].mrp);
                              print(total);
                            print(tax);
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                              child: CartItemList(
                                height: height,
                                width: width,
                                user: user.data,
                                productId: list[index].productId,
                                isOffer: list[index].isOffer,
                                noOfItems: list[index].noOfItems,
                                selectedIndex: int.parse(
                                    list[index].index),
                                product: list[index].product,
                              ),
                            );

                          },
                        );
                      }
                      return Center(child: Text("Please shop"  , style: TextStyle(color: Colors.black54 , fontSize:  22.0),),);}
                    },
                  ),
                ),
              ],
            ),
          );}
        });
  }
}
