import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/models.dart';
import 'tansactiondone.dart';

class CodPage extends StatefulWidget {
  double total;
  CodPage(this.total);
  @override
  _CodPageState createState() => _CodPageState();
}

class _CodPageState extends State<CodPage> {
  var textController = new TextEditingController();

  bool loading = false;
  void gotocomptrans() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DonePage()));
  }

  void submit( LocationModel location ) async {
    setState(() {
      loading = true;
    });
    FirebaseAuth.instance.currentUser().then((user) {
     Firestore.instance.collection('user').document(user.uid).get().then((ds) async {
       List<CartItems> cart = List<CartItems>();
       print("Transferring LIst");
       ds.data["Cart"].forEach((item) {
         print("Transferring Started");
         if(item["IsOffer"]){
           print("Transferring Offer");
           cart.add(CartItems(productId: item["ProductId"] , isOffer: true , offer: OffersModel.fromJson(jsonDecode(item["Offer"])) , Booked: true , delivered: false ));
           print("Transfer complete");
         }
         else{
           print("Transferring Product");
           cart.add(CartItems(index: item["Index"] , productId: item["ProductId"] , isOffer: false , product: Product.fromJson(jsonDecode(item["Product"])) , Booked: true , delivered: false ));
           print("Add complete");
         }
       });
       print("__________________________________");
       await Firestore.instance.collection('user').document(user.uid).updateData({
         "Cart" : cart.map((e) {
           if(e.isOffer){
             return {
               "ProductId": e.productId ,
               "IsOffer" : e.isOffer,
               "Offer" : jsonEncode(e.offer.toJson()),
               "Booked" : e.Booked,
               "Delivered" : e.delivered,
             };
           }
           else{
             return {
               "ProductId": e.productId ,
               "IsOffer" : e.isOffer,
               "Index" : e.index,
               "Product" : jsonEncode(e.product.toJson()),
               "Booked" : e.Booked,
               "Delivered" : e.delivered,
             };
           }
         }).toList(),
       });
       print("__________________________________");
       setState(() {
         loading = false;
       });
       gotocomptrans();
     });
    });



  }


//  String alternate = "";
  LocationModel location = LocationModel();
  String firstName;
  String lastName;
  String phone;
  String email;
  int select = 1;
  @override
  void initState() {
    location.type = "Home";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Address",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
        toolbarHeight: height*0.13,
        elevation: 0.0,
      ),
      body: loading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "First Name*",
                        ),
                        onChanged: (val) {
                          setState(() => firstName = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Last Name*",
                        ),
                        onChanged: (val) {
                          setState(() => lastName = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Address Line 1*",
                  ),
                  onChanged: (val) {
                    setState(() => location.addressLine1 = val);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Address Line 2*",
                  ),
                  onChanged: (val) {
                    setState(() => location.addressLine2 = val);
                  },
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Phone*",
                        ),
                        onChanged: (val) {
                          setState(() => phone = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Email*",
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "City*",
                        ),
                        onChanged: (val) {
                          setState(() => location.city = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "ZipCode*",
                        ),
                        onChanged: (val) {
                          setState(() => location.zipCode = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "State*",
                  ),
                  onChanged: (val) {
                    setState(() => location.state = val);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Country*",
                  ),
                  onChanged: (val) {
                    setState(() => location.country = val);
                  },
                ),
              ),
            ),
            Text("Make this my default address"),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 1;
                          location.type = "Home";
                        });
                      },
                      child: Container(
                        color: select == 1 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: select == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 2;
                          location.type = "Office";
                        });
                      },
                      child: Container(
                        color: select == 2 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Office",
                          style: TextStyle(
                              color: select == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 3;
                          location.type = "Others";
                        });
                      },
                      child: Container(
                        color: select == 3 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Others",
                          style: TextStyle(
                              color: select == 3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: (){
                  print("$firstName $lastName $phone $email ${location.country}  ${location.state} ${location.zipCode} ${location.city}  ${location.addressLine2} ${location.addressLine1} ${location.type}");
                  //Save Address,
                  if( firstName != null && lastName != null && phone != null && email != null && location.country != null && location.state != null && location.zipCode != null && location.city != null && location.addressLine2 != null && location.addressLine1 != null && location.type != null ){
                    submit(location);
                  }
                  else{
                    Future.delayed(Duration(milliseconds: 5000),(){
                      showDialog(context: context ,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Fill All The Details"),
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
                },
                child: Container(
                  height: 60.0,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0 , vertical:  10.0),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 20.0,
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
}
