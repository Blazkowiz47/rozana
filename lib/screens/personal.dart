import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/models.dart';

class Personal extends StatefulWidget {
  UserModel user;
  final String uid;
  Personal({this.user,this.uid});
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.13,
        centerTitle: true,
        title: Text(
          "Personal Details",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              //Name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      widget.user.firstName ?? "William",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                GestureDetector(
                onTap: (){
                  showDialog(context: context,
                        builder: (BuildContext context){
                          String field;  return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Firestore.instance.collection('user').document(widget.uid).updateData({
                                    "FirstName" : field.trim(),
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                },
                child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              //User Name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last Name",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      widget.user.lastName ?? "William",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                GestureDetector(
                onTap: (){
                  showDialog(context: context,
                        builder: (BuildContext context){
                          String field;  return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Firestore.instance.collection('user').document(widget.uid).updateData({
                                    "LastName" : field,
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                },
                child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              //Email ID
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email ID",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      child: Center(
                        child: Text(
                          widget.user.emailID  ??"William@gmail.com",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                        builder: (BuildContext context){
                          String field;  return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Firestore.instance.collection('user').document(widget.uid).updateData({
                                    "EmailID" : field,
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                        },
                        child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              //Contact
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      widget.user.phoneNumber ?? "1111111111",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
    GestureDetector(
    onTap: (){
      showDialog(context: context,
                        builder: (BuildContext context){
                          String field;  return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Firestore.instance.collection('user').document(widget.uid).updateData({
                                    "PhoneNumber" : field,
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
    },
    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              //Address
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Container(
                      width: width * 0.3,
                      child: Text(
                        widget.user.addresses[0].addressLine1 ?? "xxxxxxx,tttttt,yyyyyy",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                        builder: (BuildContext context){
                          String field;
                          return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                },
                              ),
                            ],
                          );
                        });
                      },
                      child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ad Account Contact",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      child: Text(
                        "William@gmail.com",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                        builder: (BuildContext context){
                          String field;  return AlertDialog(
                            title: Text("Enter"),
                            content: TextField(
                              onChanged:(val){setState(() {
                                field = val;
                              });} ,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      },
                      child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temperature",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      "Celcius",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Manage Account",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Container(
                      width: width * 0.3,
                      child: Text(
                        "Modify Your legal Contact details",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.red[900],
                    ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
