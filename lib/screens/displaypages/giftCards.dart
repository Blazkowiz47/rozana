import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rozana/screens/displaypages/homepagewidgets/gift2.dart';
import 'dart:io';

class GiftCards extends StatefulWidget {
  @override
  _GiftCardsState createState() => _GiftCardsState();
}

class _GiftCardsState extends State<GiftCards> {
  double amount = 10.0;
  String rname;
  String message;
  String phone;
  String email;
  String name;
  File _image;
  final picker = ImagePicker();
  @override
  void initState() {
    Permission.storage.request();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Gift Cards",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
              child: Text(
                "Select your Occasion",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: height * 0.06,
                width: width * 0.25,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
                child: Center(
                    child: Text(
                      "Holi Gift",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        color: Colors.green,
                      ),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: Text(
                    "Select the Amount",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: Text(
                    "${amount.round()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: amount,
              activeColor: Colors.red[800],
              inactiveColor: Colors.red[800],
              min: 0,
              max: 10000,
              divisions: 1000,
              label: "$amount",
              onChanged: (val){
                setState(() {
                  amount = val;
                });
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: Text(
                    "Select your gift images",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      try{
                        await picker.getImage(source: ImageSource.gallery).then((val){
                          val == null ? null : setState(() {
                            _image = File(val.path);
                          });
                        });
                      }catch(e){
                        showDialog(context: context , builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Fetching Storage Failed \n ${e.toString()}"),
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
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black26,
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: height*0.2,
                width: width*0.9,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: height*0.2,
                        width: width*0.38,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/gift.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: height*0.2,
                        width: width*0.38,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/gift.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
                  child: Text(
                    "Enter The Recipient Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Center(
                      child: Text(
                        "+ Add More Participants",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width *0.05 ,vertical: 10.0 ),
              child: Container(
                height: height*0.27,
                width: width*0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image == null ?  AssetImage("images/gift.png") : FileImage(_image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: 10.0, right: 10.0),
              child: Container(
                width: width*0.9,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Recipients Name",
                  ),
                  onChanged: (val) {
                    setState(() => rname = val);
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
                    hintText: "Enter Message",
                  ),
                  onChanged: (val) {
                    setState(() => message = val);
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
                    hintText: "Enter Name",
                  ),
                  onChanged: (val) {
                    setState(() => name = val);
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
                    hintText: "Recipients Email address",
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
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
                    hintText: "Recipients phone Number",
                  ),
                  onChanged: (val) {
                    setState(() => phone = val);
                  },
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 5.0 , vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0 , vertical: 10.0),
                    child: Text(
                      "Total Amount Rate: Rs.${amount.round()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  GestureDetector(
                    onTap: (){
                      if(phone != null && email != null && name !=null && rname != null && message != null){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GiftCards2(
                            name: name,
                            rname: rname,
                            phone: phone,
                            message: message,
                            amount: amount*100,
                            email: email,
                            image: _image,
                          ),
                        ));
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
                      height: height * 0.06,
                      width: width * 0.27,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Center(
                          child: Text(
                            "Preview and Pay",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
