import 'package:flutter/material.dart';
import 'package:rozana/main.dart';
import 'package:rozana/screens/displaypages/specificCategories.dart';

class MustHaveTab extends StatelessWidget {
  MustHaveTab({
    @required this.height,
    @required this.width,
    @required this.context,
  });

  final double height;
  final double width;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SpecificCategory(
                  categoryName: "NIght Snacks",
                ),
              ),
            );
          },
          child: Container(
            height: height * 0.16,
            width: width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container( height: height*0.1 , child: Image.asset("images/snacks.png"),
    ),Text(
                  "Night Snacks",
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
                  categoryName: "Summer Drinks & Mocktails",
                ),
              ),
            );
          },
          child: Container(
            height: height * 0.16,
            width: width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container( height: height*0.1 , child: Image.asset("images/categories/${categories[1]}.png"),),
                Text(
                  "Summer Drinks & Mocktails",
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
                  categoryName: "Treat for Kids",
                ),
              ),
            );
          },
          child: Container(
            height: height * 0.16,
            width: width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container( height: height*0.1 , child: Image.asset("images/categories/${categories[2]}.png"),),
                Text(
                  "Treat for Kids",
                  style: TextStyle(fontSize: 13.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
