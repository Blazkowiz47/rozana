import 'package:flutter/material.dart';
import 'package:rozana/screens/displaypages/myorder.dart';

class DonePage extends StatefulWidget {
  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: width*0.5,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Text(
              "Completed",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                //Save Address,
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Container(
                height: 60.0,
                width: width*0.7,
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.0 , vertical:  10.0),
                child: Center(
                  child: Text(
                    "Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                //Save Address,
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyOrder(),
                ));
              },
              child: Container(
                height: 60.0,
                width: width*0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.0 , vertical:  10.0),
                child: Center(
                  child: Text(
                    "Track Order",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
