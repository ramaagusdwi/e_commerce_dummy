import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_ctr.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/provider/favorite_model.dart';
import 'package:test_mobile_apps_dev/provider/product_detail_model.dart';
import 'package:test_mobile_apps_dev/provider/product_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = '/productDetail';
  late ProductDetailModel state;

  @override
  Widget build(BuildContext context) {
    final Produk args = ModalRoute.of(context)?.settings.arguments as Produk;

    return Scaffold(
        body: ChangeNotifierProvider<ProductDetailModel>(
      create: (_) => ProductDetailModel(id: args.idProduk.toString()),
      builder: (context, Widget? child) {
        return Consumer(builder:
            (BuildContext context, ProductDetailModel state, Widget? child) {
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Brand",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "${args.namaBrand}",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
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
    }, child: Consumer<ProductDetailModel>(
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
    toggleFavorite(produk);

    setColorIconFavorite(context, produk);

    if (produk.favorite == 1) {
      context.read<FavoriteModel>().saveFavorite(produk);
    } else {
      context.read<FavoriteModel>().removeFavorite(produk);
    }
    var db = await DatabaseHelper().database;
    var produkController = ProdukCtr(dbClient: db);
    context
        .read<ProdukModel>()
        .showListProdukByBrandFromLocalDb(produkController);
    context.read<FavoriteModel>().showFavoriteProduk();
    context.read<ProductDetailModel>().switchColor();
  }

  void setColorIconFavorite(BuildContext context, Produk produk) {
    context
        .read<ProdukModel>()
        .setIndicatorColorFavorite(produk.idProduk!, produk.favorite);
  }

  void toggleFavorite(Produk produk) {
    if (produk.favorite == 0) {
      log("masuk sini favorite 0");
      produk.favorite = 1;
    } else {
      log("masuk sini favorite 1");
      //delete favorite product
      produk.favorite = 0;
    }
  }
}
