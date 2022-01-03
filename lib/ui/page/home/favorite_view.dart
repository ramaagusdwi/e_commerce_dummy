import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/favorite_model.dart';
import 'package:test_mobile_apps_dev/provider/favorite_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/item_shoes.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({Key? key}) : super(key: key);
  late FavoriteModel state;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteModel(context),
      child: Consumer(
        builder: (BuildContext context, FavoriteModel state, Widget? child) {
          print("rebuild favoriteModel!");
          this.state = state;
          return body();
        },
      ),
    );
  }

  Widget body() {
    return state.state == ResultStateFavorite.Loading
        ? const Center(
            child: CircularProgressIndicator(
            color: ColorSource.primaryColor,
          ))
        : state.state == ResultStateFavorite.Success &&
                state.favoriteProductList.isEmpty
            ? Center(
                child: vText("Belum ada produk favorit!",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorSource.black))
            : state.state == ResultStateFavorite.Failed
                ? Center(
                    child: vText(state.message,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: ColorSource.black))
                : Container(
                    margin: EdgeInsets.only(top: 16),
                    child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          for (int i = 0;
                              i < state.favoriteProductList.length;
                              i++)
                            ItemShoesCard(
                              state.favoriteProductList[i],
                            )
                        ]),
                  );
  }
}
