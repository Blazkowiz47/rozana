import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/displaypages/filter.dart';

class SpecificCategory extends StatefulWidget {
  final String categoryName;
  SpecificCategory({this.categoryName});
  @override
  _SpecificCategoryState createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  double height;
  double width;
  DatabaseService service = DatabaseService();
  bool gotCategories = false;
  List<Product> specificCategoryGlobalList;
  @override
  void initState() {
    print("Starting InitState for Get Categories");
    service
        .getProductsOfCategory(widget.categoryName.trim())
        .then((list) => gotData(list));

    print("Get Categories Completed");
    super.initState();
  }

  void gotData(List<Product> list) {
    setState(() {
      gotCategories = true;
      specificCategoryGlobalList = list;
      print("Total products:");
      print(specificCategoryGlobalList.length);
      print(gotCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Filter(),
              ));
            },
          ),
        ],
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: !gotCategories
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (specificCategoryGlobalList.length == 0)
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    itemCount: specificCategoryGlobalList.length,
                    itemBuilder: (context, index) {
                      print("Printing ItemsList Index");
                      return ItemList(
                        height: height,
                        width: width,
                        product: specificCategoryGlobalList[index],
                      );
                    },
                  ),
                ),
    );
  }
}
