import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/profile/profile_screen.dart';
import 'package:grocery_app/screens/seller/seller_home_screen.dart';
import 'package:grocery_app/screens/seller/seller_screen.dart';
import 'package:grocery_app/screens/stores/stores_screens.dart';
import 'package:grocery_app/tools/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  static int itemIndex = 0;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

const double iconSize = 25;
String exist = "";

class _MainScreenState extends State<MainScreen> {
  final screens = [
    StoresScreen(),
    OrderScreen(),
    SellerScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    _checkSeller();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 2,
      // ),
      body: MainScreen.itemIndex == 2 && exist == "seller"
          ? SellerHomeScreen()
          : screens[MainScreen.itemIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: ((value) {
            setState(() {
              MainScreen.itemIndex = value;
            });
          }),
          currentIndex: MainScreen.itemIndex,
          // selectedIconTheme:  selectedIcons[selectedIcons],
          // ignore: prefer_const_literals_to_create_immutables
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                  size: iconSize,
                ),
                label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  size: iconSize,
                ),
                label: "Orders"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.storefront_rounded,
                  size: iconSize,
                ),
                label: "Seller"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                  size: iconSize,
                ),
                label: "Profile")
          ]),
    );
  }

  Future _checkSeller() async {
    final prefs = await SharedPreferences.getInstance();
    exist = prefs.getString('seller').toString();
  }
}