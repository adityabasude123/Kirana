import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/SystemColors.dart';
import 'package:grocery_app/utils/get_info.dart';
import 'package:grocery_app/utils/add_cart_functions.dart';

import '../constants/ConstantValue.dart';
import '../screens/home/product_detailed_screen.dart';

class FavoriteProductCartWidget extends StatefulWidget {
  const FavoriteProductCartWidget(this.favoriteData,
      this.removeProductFromFavoriteListCallback, this.index);
  final favoriteData;
  final Function removeProductFromFavoriteListCallback;
  final index;

  @override
  _FavoriteProductCartWidgetState createState() =>
      _FavoriteProductCartWidgetState();
}

class _FavoriteProductCartWidgetState extends State<FavoriteProductCartWidget> {
  var productinfo;
  String unit = "";
  @override
  void initState() {
    _getProductInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, _productRouteTranslation(productinfo));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Color.fromARGB(78, 0, 0, 0),
                  offset: Offset(0, 0))
            ]),
        width: getScreenSize(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: productinfo != null
                    ? Image.network(
                        productinfo['product_image'],
                        width: 100,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset('assets/images/fruit.png'),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (getScreenSize(context).width / 2) - 70,
                          child: Text(
                            productinfo != null
                                ? productinfo['product_name']
                                : "",
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productinfo != null ? unit : "",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Text(
                                  productinfo != null
                                      ? '₹ ${productinfo['product_price']}'
                                      : '₹ 0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getProductInfo() async {
    await FirebaseDatabase.instance
        .ref(
            'sellers/${widget.favoriteData['seller_id']}/products/${widget.favoriteData['product_id']}/info')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          productinfo = value.value as Map;
          if (productinfo['product_unit'] == '/ 1 pc') {
            unit = '1 pc';
          } else {
            unit = '500gr';
          }
        });
      }
    });
  }

  void _removeProductFromFavoriteList() async {
    await FirebaseDatabase.instance
        .ref('users/${uid}/favorite/${widget.favoriteData['product_id']}')
        .remove()
        .then((value) {
      widget.removeProductFromFavoriteListCallback(widget.index);
    });
  }

  Route _productRouteTranslation(var productData) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductDetailedScreen(productData),
        transitionsBuilder: ((context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.fastOutSlowIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }));
  }
}