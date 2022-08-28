import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_controller_query.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/provider/favorite_provider.dart';
import 'package:test_mobile_apps_dev/provider/product_detail_provider.dart';
import 'package:test_mobile_apps_dev/provider/product_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = '/productDetail';
  late ProductDetailProvider state;

  @override
  Widget build(BuildContext context) {
    final Produk args = ModalRoute.of(context)?.settings.arguments as Produk;

    return Scaffold(
        body: ChangeNotifierProvider<ProductDetailProvider>(
      create: (_) => ProductDetailProvider(id: args.idProduk.toString()),
      builder: (context, Widget? child) {
        return Consumer(builder:
            (BuildContext context, ProductDetailProvider state, Widget? child) {
          print("rebuild widget-produkDetailModel!");
          this.state = state;
          return customScrollVIew(context, args);
        });
      },
    ));
  }

  CustomScrollView customScrollVIew(BuildContext context, Produk args) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Produk Detail'),
          backgroundColor: ColorSource.primaryColorOpacity50,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned(
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: AssetImage('assets/image/${args.pathImage}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10.0)),
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0),
                Positioned(
                    bottom: 30,
                    right: 20,
                    child: iconFavorite(args, context: context))
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  "${args.nama}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 32),
                Text(
                  "${args.namaBrand}",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: ColorSource.textGrey2),
                ),
                const SizedBox(height: 32),
                vText(args.harga.toString(),
                    money: true,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: ColorSource.yellow),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${args.namaBrand} : ",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: ColorSource.textGrey2),
                    ),
                    buildCircle(
                        child: const SizedBox(),
                        colorArgs: HexColor(args.warnaHex),
                        size: 40),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  InkWell iconFavorite(Produk produk,
      {double size = 30, required BuildContext context}) {
    return InkWell(onTap: () {
      handleTapFavorited(produk, context);
    }, child: Consumer<ProductDetailProvider>(
      builder: (_, state, child) {
        return state.state == ResultProductDetailState.Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Icon(
                Icons.favorite,
                size: size,
                color: state.color,
              );
      },
    ));
  }

  Future<void> handleTapFavorited(Produk produk, BuildContext context) async {
    toggleFavorite(produk, context);

    if (produk.favorite == 1) {
      context.read<FavoriteProvider>().saveFavorite(produk);
    } else {
      context.read<FavoriteProvider>().removeFavorite(produk);
    }
    var db = await DatabaseHelper().database;
    var produkController = ProdukCtr(dbClient: db);
    context
        .read<ProductProvider>()
        .showListProdukByBrandFromLocalDb(produkController);
    context.read<FavoriteProvider>().showFavoriteProduk();
    context.read<ProductDetailProvider>().switchColor();
  }

  void toggleFavorite(Produk produk, BuildContext context) {
    if (produk.favorite == 0) {
      log("masuk sini favorite 0");
      produk.favorite = 1;
      setColorIconFavorite(context, produk.idProduk!, produk.favorite);
    } else {
      log("masuk sini favorite 1");
      //delete favorite product
      produk.favorite = 0;
      setColorIconFavorite(context, produk.idProduk!, produk.favorite);
    }
  }

  void setColorIconFavorite(
      BuildContext context, int idProduk, int flagFavorite) {
    context
        .read<ProductProvider>()
        .setIndicatorColorFavorite(idProduk, flagFavorite);
  }

  Container buildCircle({
    required Widget child,
    required Color colorArgs,
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: colorArgs,
        border: Border.all(
          color: colorArgs,
        ),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
