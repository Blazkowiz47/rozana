import 'package:flutter/material.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';

List<Product> offerProducts;

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  int checked = 0;
  double height;
  double width;
  DatabaseService service = DatabaseService();
  bool gotCategories = false;
  @override
  void initState() {
    print("Starting InitState for Get Offers");
    service.getProducstsWithDiscount().then((list) => gotData(list));
    print("Get Offers Completed");
    super.initState();
  }

  void gotData(List<Product> list) {
    setState(() {
      gotCategories = true;
      offerProducts = list;
      print("Total products:");
      print(offerProducts.length);
      print(gotCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: <Widget>[
            Container(
              height: height * 0.09,
              width: width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          checked = 0;
                        });
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          color: checked == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "All",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: checked == 0 ? Colors.white : Colors.black,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          checked = 1;
                        });
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          color: checked == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Center(
                            child: Text(
                          "ATTA",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: checked == 1 ? Colors.white : Colors.black,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          checked = 2;
                        });
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          color: checked == 2
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Center(
                            child: Text(
                          "SOOJI",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: checked == 2 ? Colors.white : Colors.black,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.7,
              child: !gotCategories
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (offerProducts.length == 0)
                      ? Center(
                          child: Text(
                            "Sorry ...!!! Products Not Available",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(
                          width: width,
                          height: height,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            itemCount: offerProducts.length,
                            itemBuilder: (context, index) {
                              print("Printing ItemsList Index");
                              return ItemList(
                                height: height,
                                width: width,
                                product: offerProducts[index],
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
