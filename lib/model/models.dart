import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/screens/product.dart';

class UserModel {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String emailID;
  final String password;
  final String walletBalance;
  final List addresses;
  final List cartItems;
  final List myOrders;
  UserModel({
    this.myOrders,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.emailID,
    this.cartItems,
    this.password,
    this.addresses,
    this.walletBalance,
  });
}
class MyOrders{
  final Timestamp time;
  final String productId;
  final String index;
  final bool isOffer;
  MyOrders({this.time, this.productId, this.isOffer ,this.index});
  Map<String , dynamic> toJson () =>{
    "time" : time,
    "productId" : productId,
    "index" : index,
    "isOffer" : isOffer,
  };
  MyOrders.fromJson(Map<String, dynamic> json)
  : time = json["time"],
  productId = json["productId"],
  isOffer = json["isOffer"],
  index = json["index"];
}
class CartItems {
  final String productId;
  final OffersModel offer;
  final String index;
  final bool isOffer;
  final Product product;
  final bool Booked;
  final bool delivered;
  int noOfItems;
  CartItems({
    this.Booked,
    this.delivered,
    this.index,
    this.isOffer,
    this.offer,
    this.productId,
    this.product,
    this.noOfItems,
});
}

class LocationModel {
   String addressLine1;
   String addressLine2;
   String zipCode;
   String city;
   String state;
   String country;
   String type;
  LocationModel({
    this.addressLine1,
    this.addressLine2,
    this.zipCode,
    this.city,
    this.state,
    this.country,
    this.type,
  });
  Map<String, dynamic> toJson() =>{
    "addressLine1" : addressLine1,
    "addressLine2" : addressLine2,
    "zipCode" : zipCode,
    "city" : city,
    "country" : country,
    "state" : state,
    "type" : type
  };
  LocationModel.fromJson(Map<String, dynamic> json)
    :addressLine1 = json["addressLine1"] ,
    addressLine2 = json["addressLine2"],
    zipCode =json["zipCode"],
    city =json["city"],
   country = json["country"] ,
   state =  json["state"],
   type = json["type"] ;
}

class Product {
  final String id;
  final String addedOn;
  final String name;
  final String category;
  final List items;
  final String brand;
  Product({
    this.id,
    this.addedOn,
    this.category,
    this.name,
    this.items,
    this.brand,
  });
  Map<String, dynamic> toJson() =>
      {
        "Id" : id,
        "AddedOn" : addedOn,
        "Name" : name,
        "Category" : category,
        "Brand" : brand,
        "Items" : items.map((e){
          return jsonEncode(e.toJson());
        }).toList(),
      };
  Product.fromJson(Map<String, dynamic> json)
  :id = json["Id"],
  items = json["Items"].map((e) => DifferentItems.fromJson(jsonDecode(e))).toList(),
  addedOn = json["AddedOn"],
  name = json["Name"],
  category = json["Category"],
  brand = json["Brand"];
}

class OffersModel {
  final String tax;
  final String id;
  final String category;
  final String name;
  final String mrp;
  final String imageUrl;
  final String offerPercent;
  final String quantity;
  OffersModel({
    this.name,
    this.tax,
    this.mrp,
    this.id,
    this.imageUrl,
    this.offerPercent,
    this.quantity,
    this.category,
  });
  Map<String, dynamic> toJson() =>
      {
        "Id" : id,
        "Name" : name,
        "Category" : category,
        "Mrp" : mrp,
        "Quantity":quantity,
        "ImageUrl":imageUrl,
        "Tax":     tax,
        "OfferPercent" : offerPercent,
      };
  OffersModel.fromJson(Map<String, dynamic> json)
      :id = json["Id"],
        name = json["Name"],
        category = json["Category"],
        mrp = json["Mrp"],
        quantity = json["Quantity"],
        tax = json["Tax"],
        imageUrl = json["ImageUrl"],
        offerPercent = json["OfferPercent"];


}

class DifferentItems {
  final String mrp;
  final String quantity;
  final String discount;
  final String tentativeNewStockArrivalDate;
  final String quantityInStock;
  final String imageUrl;
  final String tax;
  DifferentItems({
    this.discount,
    this.imageUrl,
    this.mrp,
    this.quantity,
    this.quantityInStock,
    this.tentativeNewStockArrivalDate,
    this.tax,
  });
  Map <String , dynamic> toJson() =>
      {
 "Mrp" : mrp,
  "Quantity":quantity,
 "Discount":discount,
 "TentativeNewStockArrivalDate":tentativeNewStockArrivalDate,
 "QuantityInStock":quantityInStock,
 "ImageUrl":imageUrl,
   "Tax":     tax,
      };
  DifferentItems.fromJson(Map<String, dynamic> json)
  : mrp = json["Mrp"],
  quantity = json["Quantity"],
  discount = json["Discount"],
  tax = json["Tax"],
  imageUrl = json["ImageUrl"],
  quantityInStock = json["QuantityInStock"],
  tentativeNewStockArrivalDate = json["TentativeNewStockArrivalDate"];
}

class ItemList extends StatefulWidget {
  final Product product;
  final double height;
  final double width;
  ItemList({this.product, this.height, this.width});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  DifferentItems selectedItem;
  List<DifferentItems> items;
  String getIndex(){
    for(int i = 0 ; i < items.length ; i++){
      if(items[i] == selectedItem){
        return "$i";
      }
    }
  }
  @override
  void initState() {
    setState(() {
      items = widget.product.items;
      selectedItem = widget.product.items[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductPage(widget.product ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          //This is the product Item Widget
          width: widget.width,
          height: widget.height * 0.22,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Row(
            children: <Widget>[
              //Displays Image
              Container(
                width: widget.width * 0.32,
                height: widget.height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  border: Border.all(color: Colors.black, width: 1.0),
                  image: DecorationImage(
                    image: NetworkImage(selectedItem.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
                // child: Image.network(selectedItem.imageUrl),
              ),
              SizedBox(
                width: widget.width * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.product.brand),
                            Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.width * 0.1,
                        ),
                        // Offer offered in percent
                        Container(
                          height: 30.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.red[700],
                          ),
                          child: Center(
                            child: Text(
                              "${selectedItem.discount}% OFF",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<DifferentItems>(
                      value: selectedItem,
                      isDense: true,
                      onChanged: (DifferentItems item) => setState(() {
                        selectedItem = item;
                      }),
                      selectedItemBuilder: (BuildContext context) {
                        return items.map<Widget>((DifferentItems item) {
                          return Text(
                            item.quantity,
                            textAlign: TextAlign.center,
                          );
                        }).toList();
                      },
                      items: items.map((DifferentItems item) {
                        return DropdownMenuItem<DifferentItems>(
                          child: Text("${item.quantity}    "),
                          value: item,
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "MRP. \u{20B9} ${selectedItem.mrp ?? "0"}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              "\u{20B9} ${(1 - double.parse(selectedItem.discount) / 100) * double.parse(selectedItem.mrp)}",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.width * 0.10,
                        ),
                        FlatButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.currentUser().then((user){
                              if(user.uid != null){
                                UserDatabaseService userService = UserDatabaseService(user: user);
                                userService.addToCart(productId: widget.product.id, index: getIndex(), isOffer: false , product: widget.product);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      Future.delayed(Duration(milliseconds: 3000) , (){
                                        Navigator.of(context).pop();
                                      });
                                      return AlertDialog(title: Text("Cart"),content: Text("Product Has been added to cart"),actions: <Widget>[
                                        FlatButton(
                                          child: Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],);
                                    }
                                );
                              }
                              else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            });
                          },
                          child: Text(
                            "+  ADD",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemList extends StatefulWidget {
  final OffersModel offer;
  final Product product;
  final int selectedIndex;
  final double height;
  final double width;
  final bool isOffer;
  final FirebaseUser user;
  final int noOfItems;
  final String productId;
  CartItemList({this.product , this.productId , this.user , this.noOfItems,this.offer, this.height, this.width, this.selectedIndex,this.isOffer});
  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  DifferentItems selectedItem;
  int selectedProductQuantity;

  @override
  void initState() {
    widget.isOffer ? null : setState(() {
      selectedProductQuantity = widget.selectedIndex;
      selectedItem = widget.product.items[selectedProductQuantity];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        //This is the product Item Widget
        width: widget.width,
        height: widget.height * 0.25,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            //Displays Image
            Container(
              width: widget.width * 0.32,
              height: widget.height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(color: Colors.black, width: 1.0),
                image: DecorationImage(
                  image: NetworkImage( !widget.isOffer ? selectedItem.imageUrl : widget.offer.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
              // child: Image.network(selectedItem.imageUrl),
            ),
            SizedBox(
              width: widget.width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(!widget.isOffer ? widget.product.brand : ""),
                          Text(
                            !widget.isOffer ?widget.product.name : widget.offer.name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: widget.width * 0.1,
                      ),
                      // Offer offered in percent
                      Container(
                        height: 30.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.red[700],
                        ),
                        child: Center(
                          child: Text(
                            "${ !widget.isOffer ? selectedItem.discount : widget.offer.offerPercent}% OFF",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // DropdownButton<DifferentItems>(
                  //   value: selectedItem,
                  //   isDense: true,
                  //   onChanged: (DifferentItems item) => setState(() {
                  //     selectedItem = item;
                  //   }),
                  //   selectedItemBuilder: (BuildContext context) {
                  //     return items.map<Widget>((DifferentItems item) {
                  //       return Text(
                  //         item.quantity,
                  //         textAlign: TextAlign.center,
                  //       );
                  //     }).toList();
                  //   },
                  //   items: items.map((DifferentItems item) {
                  //     return DropdownMenuItem<DifferentItems>(
                  //       child: Text("${item.quantity}    "),
                  //       value: item,
                  //     );
                  //   }).toList(),
                  // ),
                  Text("${ !widget.isOffer ? selectedItem.quantity : widget.offer.quantity}    "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "MRP. \u{20B9} ${ !widget.isOffer ? selectedItem.mrp : widget.offer.mrp}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            "\u{20B9} ${(1 - double.parse( !widget.isOffer ? selectedItem.discount : widget.offer.offerPercent) / 100) * double.parse( !widget.isOffer ? selectedItem.mrp : widget.offer.mrp)}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: widget.width * 0.10,
                      ),
                      FlatButton(
                        onPressed: () async {
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                           UserDatabaseService(user:user).removeItem( isOffer: widget.isOffer , productId: widget.isOffer ? widget.offer.id :  widget.product.id.trim() , index: widget.isOffer ? null : widget.selectedIndex.toString().trim());
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          try{
                            UserDatabaseService(user: widget.user).updateItemCount(productId: widget.productId , noOfItems: widget.noOfItems - 1);
                            showDialog(context: context , builder: (BuildContext context){
                              return Container(
                                height: 150.00,
                                width: 200.0,
                                child: AlertDialog(
                                  title: Text("Updating"),
                                  content: Center(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Please wait"),
                                      CircularProgressIndicator(),
                                    ],
                                  ),),
                                ),
                              );
                            });
                            Future.delayed(Duration(milliseconds: 2000) , (){
                              Navigator.of(context).pop();
                            });
                          }catch(e){
                            Future.delayed(Duration(milliseconds: 3000), (){
                              showDialog(context: context , builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Seems to be an Error"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Approve'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text("${widget.noOfItems}"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            try{
                              UserDatabaseService(user: widget.user).updateItemCount(productId: widget.productId , noOfItems: widget.noOfItems + 1);
                              showDialog(context: context , builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Updating"),
                                  content: Center(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Please wait"),
                                      CircularProgressIndicator(),
                                    ],
                                  ),),
                                );
                              });
                              Future.delayed(Duration(milliseconds: 2000) , (){
                                Navigator.of(context).pop();
                              });
                            }catch(e){
                              Future.delayed(Duration(milliseconds: 3000), (){
                                showDialog(context: context , builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("Seems to be an Error"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Approve'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                              });
                            }
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
