import 'package:flutter/material.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/home_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/home/account_view.dart';
import 'package:test_mobile_apps_dev/ui/page/home/product_view.dart';
import 'package:test_mobile_apps_dev/ui/widget/coachmark_ballon.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_tooltip.dart';

import 'favorite_view.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeModel homeModel;

  final TooltipController _controller = TooltipController();
  bool done = false;

  @override
  void initState() {
    // _controller.start(); // starts tooltip display from the beginning
    _controller.onDone(() {
      setState(() {
        done = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            return OverlayTooltipScaffold(
              startWhen: (initializedWidgetLength) async {
                await Future.delayed(const Duration(milliseconds: 500));
                return initializedWidgetLength == 1 && !done;
              },
              overlayColor: ColorSource.blackOverlayBg,
              tooltipAnimationCurve: Curves.linear,
              tooltipAnimationDuration: const Duration(milliseconds: 1000),
              controller: _controller,
              builder: (BuildContext context) {
                return buildScaffold(_widgetOptions, _onItemTapped);
              },
            );
            // return buildScaffold(_widgetOptions, _onItemTapped);
          },
        ));
  }

  Scaffold buildScaffold(
      List<Widget> _widgetOptions, void _onItemTapped(int index)) {
    return Scaffold(
        backgroundColor: ColorSource.white,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: _widgetOptions.elementAt(homeModel.index),
              ),
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: CoachMarkBallon(),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: OverlayTooltipItem(
                      tooltipVerticalPosition: TooltipVerticalPosition.TOP,
                      displayIndex: 0,
                      tooltip: (controller) => Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 50),
                            child: MTooltip(
                                title:
                                    'Lihat daftar produk yang ingin kamu beli disini',
                                controller: controller),
                          ),
                      child: Container())),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
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
