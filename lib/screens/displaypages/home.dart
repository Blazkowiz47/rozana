import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/screens/displaypages/homepagewidgets/categoryTab.dart';
import 'package:rozana/screens/displaypages/homepagewidgets/musthavewidget.dart';
import 'package:rozana/screens/displaypages/homepagewidgets/offersList.dart';
import 'package:rozana/screens/displaypages/searchResults.dart';
import 'package:rozana/screens/displaypages/specificCategories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double height;
  double width;
  String searchQuery;
  int currentIndex = 0;
  bool gotOffers = false;
  TextEditingController _searchQuery = TextEditingController();
  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("InitState Started");
    DatabaseService().getOffersList().whenComplete(
          () => setState(() {
            gotOffers = true;
          }),
        );

    print("InitSate completed");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        //Search Bar
        Container(
          width: width,
          height: 55,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.055, vertical: height * 0.009),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchResultsForHomeScreen(
                        query: searchQuery,
                      ),
                    ));
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
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 16.0,
                    ),
                    hintText: "Search Products",
                    prefixIcon: GestureDetector(
                      onTap: () {
                        print(searchQuery);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchResultsForHomeScreen(
                            query: searchQuery,
                          ),
                        ));
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
        //Contains remaining objects
        Flexible(
          child: Container(
            height: height * 0.9,
            width: width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  //Contains the starting ad which can be changed by changing the ad.png file in images directory
                  Container(
                    width: width,
                    height: height * 0.21,
                    child: Swiper(
                      itemCount: 4,
                      itemBuilder: (context ,index){
                        return Container(
                          width: width,
                          height: height * 0.21,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/artboard$index.png"),
                                fit: BoxFit.fill,
                              )),
                        );
                      },
                    ),
                  ),
                  //Showcases the gaurantees
                  Container(
                    width: width,
                    height: height * 0.15,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: width * 0.3,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Our",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Gaurantees",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: VerticalDivider(
                            width: width * 0.005,
                            thickness: width * 0.003,
                            color: Colors.black26,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/gaurantee1.png"),
                                Text(
                                  "Quality",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  "You can trust",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/gaurantee2.png"),
                                Text(
                                  "Upto \u{20B9}200",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  "Free Delivery",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/gaurantee3.png"),
                                Text(
                                  "On Time",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  "Gaurantees",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //divider
                  Divider(
                    height: height * 0.003,
                    thickness: height * 0.003,
                  ),
                  //Creates Tab view for Category , New Arrival and Budget Friendly
                  // CategoryTab(
                  //     width: width,
                  //     height: height,
                  //     context: context),
                  DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //Shows Tab Bar
                        Container(
                          height: height * 0.065,
                          width: width,
                          child: TabBar(
                            tabs: <Widget>[
                              Tab(
                                text: "Category",
                              ),
                              Tab(
                                text: "New Arrival",
                              ),
                              Tab(
                                text: "Budget Friendly",
                              ),
                            ],
                          ),
                        ),
                        //Shows Tab Bar View
                        Container(
                          width: width,
                          padding: EdgeInsets.all(1.0),
                          height: height * 0.76,
                          child: TabBarView(
                            children: <Widget>[
                              CategoryTab(
                                  headimg: "images/categoryhead.png",
                                  head: "Shop by Category",
                                  width: width,
                                  height: height,
                                  context: context),
                              CategoryTab(
                                  headimg: "images/beautyhead.png",
                                  head: "Shop by New Arrival",
                                  width: width,
                                  height: height,
                                  context: context),
                              CategoryTab(
                                  headimg: "images/musthavehead.png",
                                head: "Shop by Budget Friendly",
                                  width: width,
                                  height: height,
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Contains the offers horizontal list
                  gotOffers
                      ? OfferList(
                          width: width,
                          height: height,
                        )
                      : Container(),
                  //Oil and Ghee Banner
                  Container(
                    height: height * 0.13,
                    width: width,
                    padding: EdgeInsets.all(0.0),
                    margin: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   spreadRadius: 2.50,
                        //   blurRadius: 2.50,
                        //   color: Colors.black26,
                        // )
                      ],
                      image: DecorationImage(
                        image: AssetImage("images/oilgheebanner.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //Grocery Ad
                  Container(
                    padding: EdgeInsets.all(0.0),
                    width: width,
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/grocerybanner.png"),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          // BoxShadow(
                          //   color: Colors.black26,
                          // ),
                        ]),
                  ),
                  //Must Have category
                  Container(
                    width: width,
                    height: height * 0.308,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            top: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            child: Center(
                              child: Text(
                                "Must Have",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            width: width,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/musthavehead.png"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            width: width,
                            height: height * 0.22,
                            child: MustHaveTab(
                                height: height, width: width, context: context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Ad
                  Container(
                    width: width,
                    height: height * 0.27,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("images/ad2.png"),
                      fit: BoxFit.fitWidth,
                    )),
                  ),
                  //Snack Store
                  Container(
                    width: width,
                    height: height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            top: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            child: Center(
                              child: Text(
                                "Snack Store",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            width: width,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/snackstorehead.png"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(0.0),
                            width: width,
                            height: height * 0.4,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName: "Noodles & Pasta",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.5,
                                                height: height * 0.17,
                                                child: Image.asset(
                                                    "images/Noodles & Pasta.png",
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              Text(
                                                "Noodles & Pasta",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName: "Chips & Popcorn",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.5,
                                                height: height * 0.17,
                                                child: Image.asset(
                                                    "images/Chips & Popcorn.png",
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              Text(
                                                "Chips & Popcorn",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName:
                                                    "Namkeen & Savouries",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.5,
                                                height: height * 0.17,
                                                child: Image.asset(
                                                    "images/Namkeen & Savouries.png",
                                                  fit:BoxFit.fitHeight,
                                                ),
                                              ),
                                              Text(
                                                "Namkeen & Savouries",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName: "Crispy Snacks",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.5,
                                                height: height * 0.17,
                                                child: Image.asset(
                                                    "images/Crispy Snacks.png",
                                                  fit:BoxFit.fitHeight,
                                                ),
                                              ),
                                              Text(
                                                "Crispy Snacks",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Beauty Store
                  Container(
                    width: width,
                    height: height * 0.5,
                    // decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black26,
                    //       spreadRadius: 1,
                    //     ),
                    //   ],
                    // ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            top: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            child: Center(
                              child: Text(
                                "The Beauty Store",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            width: width,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/beautyhead.png"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(0.0),
                            width: width,
                            height: height * 0.4,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName: "Summer Makeup",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: width * 0.5,
                                                height: height * 0.17,
                                                alignment: Alignment.topCenter,
                                                child: Image.asset(
                                                    "images/Summer Makeup.png"),
                                              ),
                                              Text(
                                                "Summer Makeup",
                                                style:
                                                    TextStyle(fontSize: 13),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName:
                                                    "Facewash & Sumer Skin Care",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/Facewash & Sumer Skin Care.png"),
                                              Text(
                                                "Facewash & Sumer Skin Care",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName: "Summer Care",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/Summer Care.png"),
                                              Text(
                                                "Summer Care",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificCategory(
                                                categoryName:
                                                    "Shaving & Men's Grooming",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.5,
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/Shaving & Men's Grooming.png"),
                                              Text(
                                                "Shaving & Men's Grooming",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Just to make it look nice

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
