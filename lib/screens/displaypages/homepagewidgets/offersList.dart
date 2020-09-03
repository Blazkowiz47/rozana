import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rozana/main.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
/*
  List View Builder For offers list 
  If Offers are present, displays offers list, else nothing.
*/

class OfferList extends StatelessWidget {
  final double height;
  final double width;

  OfferList({this.height, this.width});

  // Build a stream builder which collects offers from database
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(7.0),
        margin: EdgeInsets.all(0.0),
        height: height * 0.39,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            // BoxShadow(
            //   spreadRadius: 2.50,
            //   blurRadius: 5.0,
            //   color: Colors.black26,
            // )
          ],
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: offersGlobalList.length,
          itemBuilder: (context, index) {
            print(index);
            print(offersGlobalList[index].name);
            return OfferCard(
              height: height,
              width: width,
              offer: offersGlobalList[index],
            );
          },
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final double height;
  final double width;
  final OffersModel offer;
  OfferCard({
    this.height,
    this.width,
    this.offer,
  });
  double offerPrice;
  @override
  Widget build(BuildContext context) {
    offerPrice =
        double.parse(offer.mrp) * (1 - double.parse(offer.offerPercent) / 100);
    print(offer.mrp);
    print(offer.offerPercent);
    print("Details Here -------------------");
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: height * 0.17,
                width: width * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(offer.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 20.0,
                child: Container(
                  height: height * 0.1,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.red[500],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                    "${offer.offerPercent}%\nOFF",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Text(
              offer.name,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Text(offer.quantity),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Row(
              children: [
                Text("MRP :"),
                Text(
                  offer.mrp,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Text("Rs. $offerPrice"),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.194,
            ),
            child: Container(
              height: height * 0.04,
              width: width * 0.15,
              padding: EdgeInsets.all(0.0),
              child: FlatButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser().then((user) {
                    if(user.uid != null){
                      UserDatabaseService userService = UserDatabaseService(user: user);
                      userService.addToCart(productId: offer.id, isOffer : true , offer: offer);
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
                child: AutoSizeText("Add"),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
