import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hot Deals" , style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_basket), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.33,
            width: width,
            child: Swiper(
              itemCount: widget.product.items.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.product.items[index].imageUrl,
                  fit: BoxFit.fitHeight,
                );
              },
              pagination: SwiperPagination(),
            ),
            //Add UI Part Here
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0 , vertical: 2.50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.red[900],
                      ),
                      child: Text(
                        "${widget.product.items[selectedIndex].discount} % OFF",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0 , vertical: 2.50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: Colors.lightBlue),
                      ),
                      child: Text(
                        widget.product.brand,
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.currentUser().then((user){
                      if(user.uid != null){
                        UserDatabaseService userService = UserDatabaseService(user: user);
                        userService.addToCart(productId: widget.product.id, index: selectedIndex.toString(), isOffer: false , product: widget.product);
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.green,
                    ),
                    child: Text(
                      "+ ADD",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "MRP : \u20B9 ${widget.product.items[selectedIndex].mrp}",
                      style: TextStyle(
                        fontSize : 17.0,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Text(
                      "\u20B9 ${double.parse(widget.product.items[selectedIndex].mrp)*(1- double.parse(widget.product.items[selectedIndex].discount)/100)}",
                      style: TextStyle(
                        fontSize : 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Pack Size",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 23.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Flexible(
            child: ListView.builder(
              itemCount: widget.product.items.length,
              itemBuilder: (context , index){
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black , width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10.0),
                      leading: Text(
                        widget.product.items[index].quantity,
                        style: TextStyle(
                          fontSize: 27.0,
                          color: Colors.black54,
                        ),
                      ),
                      title:Padding(
                        padding:  EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\u20B9 ${double.parse(widget.product.items[index].mrp)*(1- double.parse(widget.product.items[index].discount)/100)}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  "${widget.product.items[index].discount} % OFF",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "MRP : \u20B9 ${widget.product.items[index].mrp}",
                              style: TextStyle(
                                fontSize : 17.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(index == selectedIndex ? Icons.check_box : Icons.check_box_outline_blank , size: 30.0,),
                        onPressed: (){
                          print(selectedIndex);
                          setState(() {selectedIndex = index;});
                          print(selectedIndex);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
