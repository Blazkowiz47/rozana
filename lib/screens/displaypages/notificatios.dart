import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("notification").document("F9Wgft4TldULZQqf6ikRcVRxrox1").get().asStream(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          if (!snapshot.hasData)
            return Center(child: Image.asset("images/notification.png"),);
          List notification = snapshot.data["notification"];
          return ListView.builder(
            itemCount: notification.length,
            itemBuilder: (context , index){
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0),
                child: Container(
                  color: Colors.white,
                  width: width,
                  height: height*0.2,
                  child: Center(
                    child: Text(
                      notification[index] ?? "",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ) ;
        },
      ),
    );
  }
}
