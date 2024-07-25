import 'package:bitirme_projesi/ui/components/bottom_nav_bar.dart';
import 'package:bitirme_projesi/ui/views/account_page.dart';
import 'package:bitirme_projesi/ui/views/shop_page.dart';
import 'package:bitirme_projesi/ui/views/sepet_sayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entity/yemekler.dart';


class RouterPage extends StatefulWidget {


  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int _selectedIndex=0;

  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

   final List<Widget> _pages = [
     const ShopPage(),
     const SepetSayfa(),
     const AccountPage(),
   ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],

    );

  }
}
