import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/favorite_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/item_shoes.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({Key? key}) : super(key: key);
  late FavoriteProvider state;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, FavoriteProvider state, Widget? child) {
        log("rebuild favoriteModel!");
        log(state.state.name, name: 'cekStateFavorite');
        this.state = state;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: body(),
        );
      },
    );
  }

  Widget body() {
    log(state.favoriteProductList.length.toString(), name: 'favoriteLenght');

    return state.state == ResultStateFavorite.Loading
        ? _buildLoading()
        : state.state == ResultStateFavorite.Success &&
                state.favoriteProductList.isEmpty
            ? EmptyView()
            : state.state == ResultStateFavorite.Failed
                ? FailedView()
                : Container(
                    // margin: EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            vText("Produk Favorite Count: ",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorSource.black),
                            vText("${state.favoriteProductList.length}",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorSource.black),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.count(
                              primary: false,
                              // padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                              children: [
                                for (int i = 0;
                                    i < state.favoriteProductList.length;
                                    i++)
                                  ItemShoesCard(
                                    state.favoriteProductList[i],
                                  )
                              ]),
                        ),
                      ],
                    ),
                  );
  }

  Center FailedView() {
    return Center(
        child: vText(state.message,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: ColorSource.black));
  }

  Center EmptyView() {
    return Center(
        child: vText("Belum ada produk favorit!",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: ColorSource.black));
  }

  Center _buildLoading() {
    return const Center(
        child: CircularProgressIndicator(
      color: ColorSource.primaryColor,
    ));
  }
}
