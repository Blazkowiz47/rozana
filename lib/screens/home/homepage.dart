import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rozana/model/database.dart';
import 'package:rozana/model/models.dart';
import 'package:rozana/screens/displaypages/cart.dart';
import 'package:rozana/screens/displaypages/categories.dart';
import 'package:rozana/screens/displaypages/home.dart';
import 'package:rozana/screens/displaypages/myAccount.dart';
import 'package:rozana/screens/displaypages/offers.dart';
import 'package:rozana/screens/displaypages/search.dart';
import 'package:rozana/screens/displaypages/filter.dart';
import 'package:rozana/screens/home/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> widgetList = [
    Home(),
    Categories(),
    Search(),
    Offers(),
    Cart(),
  ];
  List<String> widgetTitle = [
    "Home",
    "Categories",
    "Search",
    "Offers",
    "Cart",
  ];

  UserModel user;
  bool userLogged = false;
  String uid;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      if(value != null){
        setState(() {
          uid = value.uid;
        });
        print("Got User");
        DatabaseService(uid: value.uid).getUserModel().then((value) {
          setState((){
            user = value;
            userLogged = true;
          });
          print("User Set");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void goBack() {
      setState(() {
        currentIndex = 0;
      });
    }
    void navigateFromDrawerToCart() {
      setState(() {
        currentIndex = 4;
      });
    }
    void navigateFromDrawerToOffers() {
      setState(() {
        currentIndex = 3;
      });
    }
    void navigateFromDrawerToCategories() {
      setState(() {
        currentIndex = 1;
      });
    }

    List<Widget> widgetAppBar = [
      homeAppBar(),
      categoriesAppBar(
        goback: goBack,
      ),
      searchAppBar(
        goback: goBack,
      ),
      offersAppBar(
        goback: goBack,
      ),
      cartAppBar(
        goback: goBack,
      ),
    ];



    return Scaffold(
      appBar: widgetAppBar[currentIndex],
      body: widgetList[currentIndex],
      drawer: currentIndex != 0
          ? null
          : AppDrawer(
              navigateFromDrawerToCart: navigateFromDrawerToCart,
              navigateFromDrawerToOffers: navigateFromDrawerToOffers,
              navigateFromDrawerToCategories: navigateFromDrawerToCategories,
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        selectedIconTheme: Theme.of(context).iconTheme,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedIconTheme: Theme.of(context).accentIconTheme,
        unselectedItemColor: Theme.of(context).accentIconTheme.color,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: (value) => setState(() => currentIndex = value),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Categories"),
            icon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Search"),
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Offers"),
            icon: Icon(
              Icons.local_offer,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("Cart"),
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
    );
  }

  Widget homeAppBar() {
    return AppBar(
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Location",
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.openSans().fontFamily,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                userLogged ? user.addresses[0].addressLine1 : "Current Location",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.clip,
              ),
              Icon(
                Icons.edit,
                size: 15.0,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyAccount(),
            ));
          },
        ),
      ],
    );
  }

  Widget categoriesAppBar({Function goback}) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => goback(),
      ),
      title: Text(
        "Categories",
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
      ),
    );
  }

  Widget searchAppBar({Function goback}) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => goback(),
      ),
      title: Text(
        "Search",
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
      ),
    );
  }

  Widget offersAppBar({Function goback}) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => goback(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.tune),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Filter(),
            ));
          },
        ),
      ],
      title: Text(
        "Offers",
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget cartAppBar({Function goback}) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => goback(),
      ),
      title: Text(
        "Cart",
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
      ),
    );
  }
}
