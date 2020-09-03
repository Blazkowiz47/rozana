import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/main.dart';
import 'package:rozana/screens/displaypages/specificCategories.dart';

class CategoryTab extends StatelessWidget {
  CategoryTab({
    @required this.width,
    @required this.height,
    @required this.context,
    this.headimg,
    this.head,
  });
  final String head;
  final String headimg;
  final double width;
  final double height;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(bottom: 5.0),
          child: Container(
            width: width,
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
                        head,
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
                        image: AssetImage(headimg),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    width: width,
                    height: height * 0.18,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SpecificCategory(
                                    categoryName: categories[0],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: width * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                      "images/categories/${categories[0]}.png"),
                                  Text(
                                    categories[0],
                                    style: TextStyle(fontSize: 13.0),
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
                                  builder: (context) => SpecificCategory(
                                    categoryName: categories[1],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: width * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                      "images/categories/${categories[1]}.png"),
                                  Text(
                                    categories[1],
                                    style: TextStyle(fontSize: 13.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[2],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[2]}.png"),
                            Text(
                              categories[2],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[3],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[3]}.png"),
                            Text(
                              categories[3],
                              style: TextStyle(fontSize: 12.5),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[4],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[4]}.png"),
                            Text(
                              categories[4],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[5],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[5]}.png"),
                            Text(
                              categories[5],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[6],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[6]}.png"),
                            Text(
                              categories[6],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[7],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[7]}.png"),
                            Text(
                              categories[7],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[8],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[8]}.png"),
                            Text(
                              categories[8],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[9],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("images/categories/${categories[9]}.png"),
                            Text(
                              categories[9],
                              style: TextStyle(fontSize: 12.5),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpecificCategory(
                              categoryName: categories[10],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                                "images/categories/${categories[10]}.png"),
                            Text(
                              categories[10],
                              style: TextStyle(fontSize: 13.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
    );
  }
}
