import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/displaypages/offers.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // void sortPriceLowToHigh() {
  //   setState(() {
  //     offerProducts.sort((a, b) => a.items[0].mrp.compareTo(b.items[0].mrp));
  //   });
  // }

  // void sortPriceHighToLow() {
  //   setState(() {
  //     offerProducts.sort((a, b) => a.items[0].mrp.compareTo(b.items[0].mrp));
  //     offerProducts.reversed;
  //   });
  // }

  // void sortAlphabetical() {
  //   offerProducts.sort(
  //       (a, b) => a.name.substring(0, 1).compareTo(b.name.substring(0, 1)));
  //   offerProducts.reversed;
  //   List<Product> temp = offerProducts;
  //   setState(() {
  //     offerProducts = temp;
  //   });
  // }

  // void sortByOffer() {
  //   setState(() {
  //     offerProducts
  //         .sort((a, b) => a.items[0].discount.compareTo(b.items[0].discount));
  //     offerProducts.reversed;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int radioValue = -1;
    void _handleRadioValueChange(int value) {
      setState(() {
        radioValue = value;
      });
      print(radioValue);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Filter",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Shows Tab Bar
            Container(
              height: height * 0.1,
              width: width,
              child: TabBar(
                indicatorColor: Colors.red[500],
                indicatorWeight: 4.0,
                tabs: <Widget>[
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Refined By",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sort By",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Shows Tab Bar View
            Container(
              width: width,
              padding: EdgeInsets.all(1.0),
              height: height * 0.67,
              child: TabBarView(
                children: <Widget>[
                  //Refined By Tab Page
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Brand",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 35.0,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Divider(
                          height: 30.0,
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 35.0,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Divider(
                          height: 30.0,
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 35.0,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Divider(
                          height: 30.0,
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Food Preference",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 35.0,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Divider(
                          height: 30.0,
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  //Sort By Tab Page
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price-Low To High",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Radio<int>(
                              value: 0,
                              groupValue: radioValue,
                              activeColor: Colors.green,
                              onChanged: (index) =>
                                  _handleRadioValueChange(index),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price-High To Low",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: radioValue,
                              activeColor: Colors.green,
                              onChanged: (index) =>
                                  _handleRadioValueChange(index),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alphabetical",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Radio<int>(
                              value: 2,
                              groupValue: radioValue,
                              activeColor: Colors.green,
                              onChanged: (index) =>
                                  _handleRadioValueChange(index),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rupee Saving - High to Low",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Radio<int>(
                              value: 3,
                              groupValue: radioValue,
                              activeColor: Colors.green,
                              onChanged: (index) =>
                                  _handleRadioValueChange(index),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * 0.1,
                  width: width * 0.4,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        radioValue = -1;
                      });
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.1,
                  height: height * 0.1,
                  child: VerticalDivider(
                    width: width * 0.1,
                    thickness: 2.0,
                    color: Colors.black45,
                  ),
                ),
                Container(
                  height: height * 0.1,
                  width: width * 0.4,
                  child: FlatButton(
                    onPressed: () {
                      switch (radioValue) {
                        case 0:
                          // sortPriceLowToHigh();
                          break;
                        case 1:
                          //sortPriceHighToLow();
                          break;
                        case 2:
                          //sortAlphabetical();
                          break;
                        case 3:
                          break;
                        case -1:
                          break;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
