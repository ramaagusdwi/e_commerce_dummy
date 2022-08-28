import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/home_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/home/account_view.dart';
import 'package:test_mobile_apps_dev/ui/page/home/product_view.dart';
import 'package:test_mobile_apps_dev/ui/widget/message_ballon.dart';
import 'package:test_mobile_apps_dev/utils/extensions.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'favorite_view.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider homeModel;
  bool done = false;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();

  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();

  @override
  void initState() {
    // Future.delayed(Duration.zero, showTutorial);
    // WidgetsBinding.instance?.addPostFrameCallback((_){
    //   _layout(_);
    // });
    // initTargets();
    WidgetsBinding.instance?.addPostFrameCallback(_layout);
  }

  void _layout(_) {
    initTargets();
    Future.delayed(const Duration(milliseconds: 100));
    showTutorial();
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
      Provider.of<HomeProvider>(context, listen: false).selectedIndex(index);
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Consumer<HomeProvider>(
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_list,
                key: keyBottomNavigation1,
              ),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, key: keyBottomNavigation2),
              label: 'Favorites',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: homeModel.index,
          selectedItemColor: ColorSource.primaryColor,
          onTap: _onItemTapped,
        ));
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      hideSkip: true,
      targets: targets,
      colorShadow: ColorSource.blackOverlayBg,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    )..show();

    // tutorial.skip();
    // tutorial.finish();
    // tutorial.next(); // call next target programmatically
    // tutorial.previous(); // call previous target programmatically
  }

  void initTargets() {
    log(keyBottomNavigation1.position().dx.toString(), name: 'cekOffsetX');
    targets.clear();
    targets.add(
      TargetFocus(
          identify: "Target 1",
          keyTarget: keyBottomNavigation1,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: MessageBallon(
                descriptionLine1: 'Lihat daftar produk yang ingin',
                descriptionLine2: ' kamu beli disini',
                triangleXOffset: keyBottomNavigation1.position().dx,
                callback: () => tutorialCoachMark.next(),
              ),
            )
          ]),
    );
    targets.add(
      TargetFocus(
          identify: "Target 2",
          keyTarget: keyBottomNavigation2,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: MessageBallon(
                triangleXOffset: keyBottomNavigation2.position().dx,
                descriptionLine1: 'Lihat daftar produk ',
                descriptionLine2: ' yang kamu favoritkan',
                callback: () => tutorialCoachMark.finish(),
              ),
            )
          ]),
    );
  }
}
