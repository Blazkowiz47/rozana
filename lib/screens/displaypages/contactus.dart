import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width*0.17,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.08 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                FlutterPhoneState.startPhoneCall("708-085-5524");
              },
              child: Container(
                height: height*0.17,
                width: width*0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38 ,blurRadius: 5.0 , spreadRadius: 2.0 )],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset("images/callus.png"),
                    Center(
                      child: Text(
                        "Call Us",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.08 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                final Email email = Email(
                  body: 'Rozana App contacting',
                  subject: 'Contact Us via email',
                  recipients: ['cs@cwservices.co.in'],
                  isHTML: false,
                );
                FlutterEmailSender.send(email);
                showDialog(context: context , builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Email Sent"),
                    content: Container(
                      height: height*0.15,
                      width: width*0.8,
                      child: Text("Email Message Sent"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Approve' , style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
              },
              child: Container(
                height: height*0.17,
                width: width*0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38 ,blurRadius: 5.0 , spreadRadius: 2.0 )],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset("images/emailus.png"),
                    Center(
                      child: Text(
                        "Email Us",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.08 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                FlutterShareMe().shareToWhatsApp(msg: "Rozana App Whatsapp contact Us");
                showDialog(context: context , builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("WhatsApp Sent"),
                    content: Container(
                      height: height*0.15,
                      width: width*0.8,
                      child: Text("Whatsapp Message Sent"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Approve' , style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
              },
              child: Container(
                height: height*0.17,
                width: width*0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38 ,blurRadius: 5.0 , spreadRadius: 2.0 )],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset("images/whatsappus.png"),
                    Center(
                      child: Text(
                        "WhatsApp Us",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.08 , vertical: 10.0),
            child: GestureDetector(
              onTap: (){
                showDialog(context: context , builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Rate us"),
                    content: Container(
                      height: height*0.15,
                      width: width*0.8,
                      child: Column(
                        children: [
                          SizedBox(height: 10.0,),
                          Center(
                            child: RatingBar(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glowColor: Colors.green,
                              unratedColor: Colors.white,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Approve' , style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
              },
              child: Container(
                height: height*0.17,
                width: width*0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38 ,blurRadius: 5.0 , spreadRadius: 2.0 )],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset("images/rateus.png"),
                    Center(
                      child: Text(
                        "Rate Us",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
