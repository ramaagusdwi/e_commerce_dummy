import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        ? Center(
            child: CircularProgressIndicator(
            color: ColorSource.primaryColor,
          ))
        : state.favoriteProductList.isNotEmpty
            ? Container(
                // height: 276,
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.favoriteProductList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemShoesCard(
                          state.favoriteProductList[index],
                        )),
              )
            : state.state == ResultStateFavorite.Failed
                ? Center(
                    child: vText(state.message,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: ColorSource.black))
                : Center(
                    child: vText("Tidak ada favorit produk!",
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: ColorSource.black));
  }
}
