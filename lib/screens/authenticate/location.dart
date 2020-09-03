//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:hexcolor/hexcolor.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:rozana/model/models.dart';
//import 'package:rozana/screens/authenticate/authenticate.dart';
//
//class GetLocation extends StatefulWidget {
//  @override
//  _GetLocationState createState() => _GetLocationState();
//}
//
//class _GetLocationState extends State<GetLocation> {
//  bool _change = true;
//  void getPermission() async {
//    if(await Permission.location.isUndetermined || await Permission.location.isDenied ){
//      Permission.location.request();
//      Permission.locationAlways.request();
//      Permission.locationWhenInUse.request();
//      getPermission();
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//    var h = MediaQuery.of(context).size.height;
//    var w = MediaQuery.of(context).size.width;
//    return Material(
//      child: Container(
//        height: h,
//        width: w,
//        color: Colors.white,
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(0.0),
//              child: Container(
//                width: w,
//                height: h * 0.11,
//                padding: EdgeInsets.all(0.0),
//                decoration: BoxDecoration(
//                  color: Hexcolor("6BC65A"),
//                  borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(h * 0.022),
//                    bottomRight: Radius.circular(h * 0.022),
//                  ),
//                ),
//                child: Padding(
//                  padding: EdgeInsets.only(left: w * 0.02, top: h * 0.02),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      GestureDetector(
//                        onTap: () => _change
//                            ? Navigator.of(context).pop()
//                            : setState(() {
//                                _change = true;
//                              }),
//                        child: Padding(
//                          padding:
//                              EdgeInsets.only(left: w * 0.1, right: w * 0.1),
//                          child: Icon(
//                            Icons.keyboard_arrow_left,
//                            size: w * 0.09,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      Text(
//                        "Select Location",
//                        style: GoogleFonts.openSans(
//                          textStyle: TextStyle(
//                            fontSize: h * 0.035,
//                            color: Colors.white,
//                            decoration: TextDecoration.none,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              height: h * 0.5,
//              width: w,
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: AssetImage("images/location.png"),
//                  fit: BoxFit.fitWidth,
//                ),
//              ),
//            ),
//            Container(
//              alignment: Alignment.center,
//              child: Text(
//                "Choose Your Location",
//                style: GoogleFonts.openSans(
//                  textStyle: TextStyle(
//                    fontSize: h * 0.035,
//                    fontWeight: FontWeight.w500,
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              alignment: Alignment.center,
//              child: Text(
//                "and Start Shopping.",
//                style: GoogleFonts.openSans(
//                  textStyle: TextStyle(
//                    fontSize: h * 0.022,
//                    fontWeight: FontWeight.w300,
//                  ),
//                ),
//              ),
//            ),
//            _change
//                ? _Option1(
//                    onClick: callSetState,
//                  )
//                : _Option2(),
//          ],
//        ),
//      ),
//    );
//  }
//
//  //CallBAck function to change the state of app
//  void callSetState() {
//    setState(() {
//      _change = false;
//    });
//  }
//}
//
////Option 1 gives an option to choose location automatically
//class _Option1 extends StatefulWidget {
//  final Function onClick;
//  _Option1({this.onClick});
//  @override
//  _Option1State createState() => _Option1State();
//}
//
//class _Option1State extends State<_Option1> {
//  @override
//  Widget build(BuildContext context) {
//    var h = MediaQuery.of(context).size.height;
//    var w = MediaQuery.of(context).size.width;
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.only(
//            left: w * 0.1,
//            right: w * 0.1,
//            top: h * 0.05,
//            bottom: 10.0,
//          ),
//          child: Container(
//            width: w,
//            decoration: BoxDecoration(
//              color: Hexcolor("6BC65A"),
//              borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.white10,
//                  spreadRadius: 2.0,
//                  offset: Offset(0.0, 2.0),
//                ),
//              ],
//            ),
//            child: FlatButton(
//              onPressed: () async {
//                //Location automatically
//               try{
//                 GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
//                 Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
//                 Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//                 List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
//                 LocationModel address = LocationModel(
//                   state: placemark[0].administrativeArea ,
//                   addressLine2: placemark[0].subAdministrativeArea ,
//                   city: placemark[0].locality ,
//                   addressLine1: placemark[0].subLocality ,
//                   zipCode: placemark[0].postalCode ,
//                   country: placemark[0].country,
//                   type: "Home",
//                 );
//                 UserModel user = UserModel(addresses: [address]);
//                 AuthService auth = AuthService(user:user);
//                 auth.updateLocation();
//                 print("Location Update Complete");
//                 Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//               }catch(e){
//                 showDialog(context: context , builder: (BuildContext context){
//                   return AlertDialog(
//                     title: Text("Error"),
//                     content: Text("Get Location failed"),
//                     actions: <Widget>[
//                       FlatButton(
//                         child: Text('Okay'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//                         },
//                       ),
//                     ],
//                   );
//                 });
//                 Future.delayed(Duration(milliseconds: 5000) , (){
//                   Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//                 });
//               }
//              },
//              child: Padding(
//                padding: EdgeInsets.symmetric(vertical: h * 0.02),
//                child: Text(
//                  "Use My Current Location",
//                  style: GoogleFonts.openSans(
//                    textStyle: TextStyle(
//                      fontSize: h * 0.027,
//                      color: Colors.white,
//                      decoration: TextDecoration.none,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ),
//        GestureDetector(
//          onTap: () {
//            widget.onClick();
//          },
//          child: Text(
//            "Select Location Manually",
//            style: GoogleFonts.openSans(
//              textStyle: TextStyle(
//                fontSize: 15.0,
//                color: Colors.red,
//              ),
//              decoration: TextDecoration.underline,
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
//
//class _Option2 extends StatefulWidget {
//  @override
//  __Option2State createState() => __Option2State();
//}
//
//class __Option2State extends State<_Option2> {
//  @override
//  Widget build(BuildContext context) {
//    var h = MediaQuery.of(context).size.height;
//    var w = MediaQuery.of(context).size.width;
//    return Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: Column(
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.symmetric(
//              horizontal: w * 0.1,
//              vertical: h * 0.005,
//            ),
//            child: OutlineButton(
//              onPressed: () async {
//                //Location Manually
//
//                },
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Icon(
//                    Icons.person_pin_circle,
//                    size: h * 0.05,
//                    color: Colors.black45,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(10.0),
//                    child: Text(
//                      "Select Location",
//                      style: GoogleFonts.openSans(
//                        textStyle: TextStyle(
//                          fontSize: h * 0.027,
//                          color: Colors.black38,
//                          decoration: TextDecoration.none,
//                        ),
//                      ),
//                    ),
//                  ),
//                  Icon(
//                    Icons.arrow_drop_down,
//                    size: h * 0.05,
//                    color: Colors.black38,
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(
//              left: w * 0.1,
//              right: w * 0.1,
//              top: h * 0.05,
//              bottom: 10.0,
//            ),
//            child: Container(
//              width: w,
//              decoration: BoxDecoration(
//                color: Hexcolor("6BC65A"),
//                borderRadius: BorderRadius.all(Radius.circular(w * 0.03)),
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.white10,
//                    spreadRadius: 2.0,
//                    offset: Offset(0.0, 2.0),
//                  ),
//                ],
//              ),
//              child: FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//                  print("check");
//                },
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: h * 0.02),
//                  child: Text(
//                    "Next",
//                    style: GoogleFonts.openSans(
//                      textStyle: TextStyle(
//                        fontSize: h * 0.027,
//                        color: Colors.white,
//                        decoration: TextDecoration.none,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/models.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  void submit( LocationModel location ) async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection('user').document(user.uid).get().then((ds) async {
        await Firestore.instance.collection('user').document(user.uid).updateData({
          "Location" : [jsonEncode(location.toJson())],
        });
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      });
    });
  }


//  String alternate = "";
  LocationModel location = LocationModel();
  String firstName;
  String lastName;
  String phone;
  String email;
  int select = 1;
  @override
  void initState() {
    location.type = "Home";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Address",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
        toolbarHeight: height*0.13,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "First Name*",
                        ),
                        onChanged: (val) {
                          setState(() => firstName = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Last Name*",
                        ),
                        onChanged: (val) {
                          setState(() => lastName = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Address Line 1*",
                  ),
                  onChanged: (val) {
                    setState(() => location.addressLine1 = val);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Address Line 2*",
                  ),
                  onChanged: (val) {
                    setState(() => location.addressLine2 = val);
                  },
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Phone*",
                        ),
                        onChanged: (val) {
                          setState(() => phone = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Email*",
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "City*",
                        ),
                        onChanged: (val) {
                          setState(() => location.city = val);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                      width: width*0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "ZipCode*",
                        ),
                        onChanged: (val) {
                          setState(() => location.zipCode = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "State*",
                  ),
                  onChanged: (val) {
                    setState(() => location.state = val);
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
            //   child: Container(
            //     width: width*0.9,
            //     child: TextFormField(
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.person),
            //         hintText: "Country*",
            //       ),
            //       onChanged: (val) {
            //         setState(() => location.country = val);
            //       },
            //     ),
            //   ),
            // ),
            Text("Make this my default address"),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 1;
                          location.type = "Home";
                        });
                      },
                      child: Container(
                        color: select == 1 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Home",
                          style: TextStyle(
                            color: select == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 2;
                          location.type = "Office";
                        });
                      },
                      child: Container(
                        color: select == 2 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Office",
                          style: TextStyle(
                            color: select == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          select = 3;
                          location.type = "Others";
                        });
                      },
                      child: Container(
                        color: select == 3 ? Colors.green : Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical:  10.0),
                        child: Text(
                          "Others",
                          style: TextStyle(
                            color: select == 3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: (){
                  print("$firstName $lastName $phone $email ${location.country}  ${location.state} ${location.zipCode} ${location.city}  ${location.addressLine2} ${location.addressLine1} ${location.type}");
                  //Save Address,
                  if( firstName != null && lastName != null && phone != null && email != null && location.state != null && location.zipCode != null && location.city != null && location.addressLine2 != null && location.addressLine1 != null && location.type != null ){
                    submit(location);
                  }
                  else{
                    Future.delayed(Duration(milliseconds: 5000),(){
                      showDialog(context: context ,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Fill All The Details"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Okay'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    });
                  }
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
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
