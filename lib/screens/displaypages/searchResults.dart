import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';

class SearchResultsForHomeScreen extends StatefulWidget {
  final String query;
  SearchResultsForHomeScreen({this.query});
  @override
  _SearchResultsForHomeScreenState createState() =>
      _SearchResultsForHomeScreenState();
}

class _SearchResultsForHomeScreenState
    extends State<SearchResultsForHomeScreen> {
  double width;
  double height;
  String searchQuery;
  bool submitted = false;
  TextEditingController _searchQuery = TextEditingController();
  DatabaseService service = DatabaseService();
  bool gotQuery = false;
  List<Product> queryProducts;
  @override
  void initState() {
    if (widget.query != null) {
      print(widget.query);
      print("Starting InitState for Get Offers");
      service
          .getProductsWithSearchQuery(widget.query.trim())
          .then((list) => gotData(list));
      print("Get Offers Completed");
      setState(() {
        searchQuery = widget.query;
        submitted = true;
      });
    }
    super.initState();
  }

  void gotData(List<Product> list) {
    setState(() {
      gotQuery = true;
      queryProducts = list;
      print("Total products:");
      print(queryProducts.length);
      print(gotQuery);
    });
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              //Search Bar
              Container(
                width: width,
                height: height * 0.09,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.055, vertical: height * 0.015),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Center(
                      child: TextFormField(
                        controller: _searchQuery,
                        onChanged: (value) => searchQuery = value.trim(),
                        onFieldSubmitted: (value) {
                          print(searchQuery);
                          print("Starting InitState for Get Offers");
                          service
                              .getProductsWithSearchQuery(searchQuery.trim())
                              .then((list) => gotData(list));
                          print("Get Offers Completed");
                          setState(() {
                            submitted = true;
                          });
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        enableSuggestions: true,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: GoogleFonts.openSans().fontFamily,
                          ),
                          hintText: "Search Products",
                          prefixIcon: GestureDetector(
                            onTap: () {
                              print(searchQuery);
                              print("Starting InitState for Get Offers");
                              service
                                  .getProductsWithSearchQuery(
                                      searchQuery.trim())
                                  .then((list) => gotData(list));
                              print("Get Offers Completed");
                              setState(() {
                                submitted = true;
                              });
                            },
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              !submitted
                  ? SizedBox(
                      height: height * 0.1,
                    )
                  : Container(),
              !submitted
                  ? Image.asset(
                      "images/searchBG.png",
                    )
                  : Container(),
              !submitted
                  ? Text(
                      "SEARCH HERE",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Hexcolor("#707070"),
                        ),
                      ),
                    )
                  : Container(),
              !submitted
                  ? Text(
                      "FOR YOUR PRODUCT",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          color: Hexcolor("#707070"),
                        ),
                      ),
                    )
                  : Container(),
              submitted
                  ? !gotQuery
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : (queryProducts.length == 0)
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
                              height: height * 0.8,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                itemCount: queryProducts.length,
                                itemBuilder: (context, index) {
                                  print("Printing ItemsList Index");
                                  return ItemList(
                                    height: height,
                                    width: width,
                                    product: queryProducts[index],
                                  );
                                },
                              ),
                            )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
