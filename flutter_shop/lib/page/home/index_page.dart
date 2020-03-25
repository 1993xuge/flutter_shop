import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/page/cart/cart_page.dart';
import 'package:fluttershop/page/category/category_page.dart';
import 'package:fluttershop/page/home/home_page.dart';
import 'package:fluttershop/page/mine/mide_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;

  List<Widget> _list = List();

  @override
  void initState() {
    super.initState();

    _list
      ..add(HomePage())
      ..add(CategoryPage())
      ..add(CartPage())
      ..add(MinePage());
  }

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(KString.HOME)),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text(KString.CATEGORY)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text(KString.SHOP_CAR)),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text(KString.MINE)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: KColor.indexTabSelectedColor,
        unselectedItemColor: KColor.indexTabUnSelectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
