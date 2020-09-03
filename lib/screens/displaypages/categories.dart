import 'package:flutter/material.dart';
import 'package:rozana/main.dart';
import 'package:rozana/screens/displaypages/specificCategories.dart';

class Categories extends StatelessWidget {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        width: width,
        height: height,
        // child: SingleChildScrollView(
        //   child: Wrap(
        //     direction: Axis.horizontal,
        //     runSpacing: width * 0.0033333333333,
        //     spacing: width * 0.0033333333333,
        //     verticalDirection: VerticalDirection.down,
        //     children: <Widget>[
        //       for (String item in categories) category(item, context),
        //     ],
        //   ),
        // ),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          scrollDirection: Axis.vertical,
          itemCount: categories.length,
          padding: EdgeInsets.all(1.0),
          itemBuilder: (context, index) {
            return categoryCard(categories[index], context);
          },
        ),
      ),
    );
  }

  // Widget category(String name, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => SpecificCategory(
  //             categoryName: name,
  //           ),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       height: width * 0.33,
  //       width: width * 0.33,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Image.asset("images/categories/$name.png"),
  //           Text(
  //             "$name",
  //             style: TextStyle(fontSize: 13.0),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget categoryCard(String name, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SpecificCategory(
              categoryName: name,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("images/categories/$name.png"),
              Text(
                "$name",
                style: TextStyle(fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
