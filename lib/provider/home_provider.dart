import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int _index = 0;

  get index => _index;

  HomeProvider(){
    _index = 0; //set default view
    notifyListeners();
  }

  void selectedIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
