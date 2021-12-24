import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/home_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/home/account_view.dart';
import 'package:test_mobile_apps_dev/ui/page/home/product_view.dart';

import 'favorite_view.dart';

class HomePage extends StatelessWidget {
  static const route = '/home';
  late HomeModel homeModel;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      ProductView(),
      FavoriteView(),
      AccountView()
    ];

    void _onItemTapped(int index) {
      print("index $index");
      Provider.of<HomeModel>(context, listen: false).selectedIndex(index);
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Consumer<HomeModel>(
          builder: (context, home, child) {
            homeModel = home;
            return buildScaffold(_widgetOptions, _onItemTapped);
          },
        ));
  }

  Scaffold buildScaffold(
      List<Widget> _widgetOptions, void _onItemTapped(int index)) {
    return Scaffold(
        backgroundColor: ColorSource.white,
        body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(homeModel.index),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: homeModel.index,
          selectedItemColor: ColorSource.primaryColor,
          onTap: _onItemTapped,
        ));
  }
}
