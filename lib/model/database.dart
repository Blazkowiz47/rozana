import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rozana/main.dart';
import 'package:rozana/model/models.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //Collection Reference for Offers
  final CollectionReference offersCollection =
      Firestore.instance.collection("offers");
  final CollectionReference normalProductsCollection =
      Firestore.instance.collection("normalProducts");
  
  Future<UserModel> getUserModel() async {
    print("getting User Model");
    return await Firestore.instance.collection("user").document(uid).get().then((value) {
      return UserModel(
        phoneNumber: value.data["PhoneNumber"],
        firstName: value.data["FirstName"],
        lastName: value.data["LastName"],
        emailID: value.data["EmailID"],
        password: value.data["Password"],
        walletBalance: value.data["WalletBalance"],
        addresses: value.data["Location"].map((address){
          return LocationModel.fromJson(jsonDecode(address));
        }).toList(),
        myOrders: value.data["MyOrders"],
      );
    });
  }
  //Function to get Offers from database

  Future getOffersList() async {
    print("Initialising get Offers");
    offersGlobalList.clear();
    bool result = await offersCollection
        .getDocuments()
        .then((value) => addOffersToGloblList(value.documents));
    print("Got all offers , Here are those: ");
    print(offersGlobalList[0].name);
    if (!result) {
      offersGlobalList.clear();
    }
  }

  //Function to convert Document Snapshots to Offers Model

  bool addOffersToGloblList(List<DocumentSnapshot> ds) {
    ds.forEach((document) {
      offersGlobalList.add(OffersModel(
        id: document.documentID,
        name: document.data["Name"],
        category: document.data["Category"].join(" ").toString(),
        imageUrl: document.data["ImageUrl"],
        quantity: document.data["Quantity"],
        mrp: document.data["Mrp"],
        offerPercent: document.data["OfferPercent"],
        tax: document.data["Tax"],
      ));
    });
    return ds.length == offersGlobalList.length;
  }

  //Function to get products as per category from database

  Future<List<Product>> getProductsOfCategory(String category) async {
    print("Starting Get Categories");
    var searchQuery = category.split(" ");
    for (int i = 0; i < searchQuery.length; i++) {
      if (searchQuery[i] == "&") {
        searchQuery.removeAt(i);
        break;
      }
    }
    //there will be 4 querires
    return await normalProductsCollection
        .where("Category", arrayContainsAny: searchQuery)
        // .where("Category", isGreaterThanOrEqualTo: )
        .getDocuments()
        .then((query) => getProductsListOfParticularCategory(query.documents));
  }

  //Function to convert Document Snapshots to Products Model

  List<Product> getProductsListOfParticularCategory(List<DocumentSnapshot> ds) {
    if (ds.length != 0)
      return ds.map((doc) {
        print("Printing documents length");
        print(ds.length);
        List<DifferentItems> differentItems = List<DifferentItems>();
        for (int i = 0; i < doc.data["DifferentSizes"].length; i++) {
          differentItems.add(DifferentItems(
            mrp: doc.data["DifferentSizes"][i]["Mrp"],
            discount: doc.data["DifferentSizes"][i]["Discount"],
            imageUrl: doc.data["DifferentSizes"][i]["ImageUrl"],
            quantity: doc.data["DifferentSizes"][i]["Quantity"],
            quantityInStock: doc.data["DifferentSizes"][i]["QuantityInStock"],
            tentativeNewStockArrivalDate: doc.data["DifferentSizes"][i]
                ["TentativeNewStockArrivalDate"],
            tax: doc.data["DifferentSizes"][i]["Tax"],
          ));
        }

        return Product(
          id: doc.documentID,
          name: doc.data["Name"],
          addedOn: doc.data["AddedOn"],
          category: doc.data["Category"].join(" ").toString(),
          items: differentItems,
          brand: doc.data["Brand"],
        );
      }).toList();
    return [];
  }

  //get Product in modelform
  Product getProduct(DocumentSnapshot doc) {
        print("Printing documents length");
        List<DifferentItems> differentItems = List<DifferentItems>();
        for (int i = 0; i < doc.data["DifferentSizes"].length; i++) {
          differentItems.add(DifferentItems(
            mrp: doc.data["DifferentSizes"][i]["Mrp"],
            discount: doc.data["DifferentSizes"][i]["Discount"],
            imageUrl: doc.data["DifferentSizes"][i]["ImageUrl"],
            quantity: doc.data["DifferentSizes"][i]["Quantity"],
            quantityInStock: doc.data["DifferentSizes"][i]["QuantityInStock"],
            tentativeNewStockArrivalDate: doc.data["DifferentSizes"][i]
            ["TentativeNewStockArrivalDate"],
            tax: doc.data["DifferentSizes"][i]["Tax"],
          ));
        }
        return Product(
          id: doc.documentID,
          name: doc.data["Name"],
          addedOn: doc.data["AddedOn"],
          category: doc.data["Category"].join(" ").toString(),
          items: differentItems,
          brand: doc.data["Brand"],
        );
  }
  //Get Product with product Id
  Future<Product> getProductFromProductId(String productId) async {
    print("Starting get product from id ");
    return await normalProductsCollection.document(productId).get().then((document) => getProduct(document));
  }

  //get products with offer

  Future<List<Product>> getProducstsWithDiscount() async {
    print("Starting Get Categories");
    return await normalProductsCollection
        .where("HasDiscount", isEqualTo: "true")
        // .where("Category", isGreaterThanOrEqualTo: )
        .getDocuments()
        .then((query) => getProductsListOfParticularCategory(query.documents));
  }

  Future<List<Product>> getProductsWithSearchQuery(String name) async {
    print("Starting Get Categories");
    return await normalProductsCollection
        .where("Name", isGreaterThanOrEqualTo: name.toUpperCase().trim())
        // .where("Category", isGreaterThanOrEqualTo: )
        .getDocuments()
        .then((query) => getProductsListOfParticularCategory(query.documents));
  }
}


class UserDatabaseService{
  final FirebaseUser user;
  UserDatabaseService({this.user});
  final CollectionReference userCollection =
  Firestore.instance.collection("user");
  void addToCart({String productId , String index , bool isOffer , Product product , OffersModel offer}) async {
    DocumentSnapshot ds = await userCollection.document(user.uid).get();
    if(ds.data["Cart"].length == 0) {
      print("Cart Empty");
      if(isOffer)
        return await userCollection.document(user.uid).updateData({
        "Cart" : [{"ProductId" : productId , "IsOffer" : isOffer ,  "Offer" : jsonEncode(offer.toJson()) , "Booked" : false , "Delivered" : false , "NoOfItems" : 1}],
      });
      return await userCollection.document(user.uid).updateData({
        "Cart" : [{"ProductId" : productId , "Index" : index , "IsOffer" : isOffer , "Product" : jsonEncode(product.toJson()) , "Booked" : false , "Delivered" : false , "NoOfItems" : 1}],
      });}
    List<CartItems> cart = List<CartItems>();
    ds.data["Cart"].forEach((item) {
      print("Transferring Started");
      if(item["IsOffer"]){
        print("Transferring Offer");
        cart.add(CartItems(productId: item["ProductId"] , noOfItems: item["NoOfItems"] , isOffer: true , offer: OffersModel.fromJson(jsonDecode(item["Offer"])) , Booked: item["Booked"] ,delivered: item["Delivered"] ));
        print("Transfer complete");
      }
      else{
        print("Transferring Product");
        cart.add(CartItems(index: item["Index"] , noOfItems: item["NoOfItems"] , productId: item["ProductId"] , isOffer: false , product: Product.fromJson(jsonDecode(item["Product"])) , Booked: item["Booked"] , delivered: item["Delivered"] ));
        print("Add complete");
      }
    });
    bool alreadyPresent = false;
    for(int i = 0 ; i < cart.length ; i++){
      if((cart[i].productId == productId)&& !cart[i].Booked){
        cart[i].noOfItems = cart[i].noOfItems+ 1;
        alreadyPresent = true;
        break;
      }
    }

    if(!alreadyPresent){
      if(isOffer) {
        cart.add(CartItems(
          productId: productId,
          isOffer: isOffer,
          offer: offer,
          Booked: false,
          delivered: false,
          noOfItems: 1,
        ));
      }
      else{
        cart.add(CartItems(
          productId: productId,
          index: index,
          isOffer: isOffer,
          product: product,
          noOfItems: 1,
          Booked: false,
          delivered: false,
        ));
      }
    }

    print("Test");
    print("Test complete");
      return await userCollection.document(user.uid).updateData({
        "Cart" : cart.map((e) {
          if(e.isOffer){
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Offer" : jsonEncode(e.offer.toJson()),
              "Booked" : e.Booked,
              "Delivered": e.delivered,
              "NoOfItems" : e.noOfItems,
            };
          }
          else{
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Index" : e.index,
              "Product" : jsonEncode(e.product.toJson()),
              "Booked" : e.Booked,
              "Delivered": e.delivered,
              "NoOfItems" : e.noOfItems,
            };
          }
        }).toList(),
      });

  }

  void clearCart()async{
    return await userCollection.document(user.uid).updateData({
      "Cart" : [],
    });
  }
  Future<bool> updateItemCount({String productId , int noOfItems}) async{
    DocumentSnapshot ds = await userCollection.document(user.uid).get();
    List<CartItems> cart = List<CartItems>();
    ds.data["Cart"].forEach((item) {
      if(item["IsOffer"]){
        cart.add(CartItems(productId: item["ProductId"] , noOfItems: item["NoOfItems"] , isOffer: true , offer: OffersModel.fromJson(jsonDecode(item["Offer"])) , Booked: item["Booked"] ,delivered: item["Delivered"] ));
      }
      else{
        print("Transferring Product");
        cart.add(CartItems(index: item["Index"] , noOfItems: item["NoOfItems"] , productId: item["ProductId"] , isOffer: false , product: Product.fromJson(jsonDecode(item["Product"])) , Booked: item["Booked"] , delivered: item["Delivered"] ));
        print("Add complete");
      }
    });
    for(int i = 0 ; i < cart.length ; i++){
      if((cart[i].productId == productId) && !cart[i].Booked){
        if(noOfItems == 0) {
          cart.removeAt(i);
          break;
        }
        cart[i].noOfItems = noOfItems;
        break;
      }
    }
    try{
      await userCollection.document(user.uid).updateData({
        "Cart" : cart.map((e) {
          if(e.isOffer){
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Offer" : jsonEncode(e.offer.toJson()),
              "Booked" : e.Booked,
              "Delivered": e.delivered,
              "NoOfItems" : e.noOfItems,
            };
          }
          else{
            return {
              "ProductId": e.productId ,
              "IsOffer" : e.isOffer,
              "Index" : e.index,
              "Product" : jsonEncode(e.product.toJson()),
              "Booked" : e.Booked,
              "Delivered": e.delivered,
              "NoOfItems" : e.noOfItems,
            };
          }
        }).toList(),
      });
      return true;
    }catch(e){
      return false;
    }
  }
  void removeItem({String productId , String index , bool isOffer}) async {
    DocumentSnapshot ds = await userCollection.document(user.uid).get();
    List<CartItems> cart = List<CartItems>();
    ds.data["Cart"].forEach((item) {
      print("Transferring Started");

      if(item["IsOffer"]){
        print("Transferring Offer");
        cart.add(CartItems(productId: item["ProductId"] , isOffer: true , offer: OffersModel.fromJson(jsonDecode(item["Offer"])) , Booked: item["Booked"] ));
        print("Transfer complete");
      }
      else{
        print("Transferring Product");
        cart.add(CartItems(index: item["Index"] , productId: item["ProductId"] , isOffer: false , product: Product.fromJson(jsonDecode(item["Product"])) , Booked: item["Booked"] ));
        print("Add complete");
      }
    });
    cart.removeWhere((element) => (element.productId == productId)&&(element.isOffer == isOffer));
    return await userCollection.document(user.uid).updateData({
      "Cart" : cart.map((e) {
        if(e.isOffer){
          return {
            "ProductId": e.productId ,
            "IsOffer" : e.isOffer,
            "Offer" : jsonEncode(e.offer.toJson()),
            "Booked" : e.Booked,
            "NoOfItems" : e.noOfItems,
          };
        }
        else{
          return {
            "ProductId": e.productId ,
            "IsOffer" : e.isOffer,
            "Index" : e.index,
            "Product" : jsonEncode(e.product.toJson()),
            "Booked" : e.Booked,
            "NoOfItems" : e.noOfItems,
          };
        }
      }).toList(),
    });
  }
}