import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_mobile_apps_dev/common/navigation.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_controller_query.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/provider/favorite_provider.dart';
import 'package:test_mobile_apps_dev/provider/product_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/product_detail_page.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class ItemShoesCard extends StatelessWidget {
  late Produk data;
  ItemShoesCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log("cekTapDataItem $data");
        Navigation.intentWithData(ProductDetailPage.route, data);
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.35, //width based on 35 percent from size device / phone
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff7c94b6),
                        image: DecorationImage(
                          image: AssetImage('assets/image/${data.pathImage}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 30,
                        right: 20,
                        child: iconFavorite(data, size: 30, context: context))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 164,
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(14.0),
                      bottomRight: Radius.circular(14.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.nama}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: ColorSource.black2),
                      ),
                      Text(
                        "${data.namaBrand}",
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: ColorSource.textGrey2),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildCircle(
                              child: const SizedBox(),
                              colorArgs: HexColor(data.warnaHex),
                              size: 14),
                          vText(data.harga.toString(),
                              money: true,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: ColorSource.yellow)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCircle({
    required Widget child,
    required Color colorArgs,
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      // padding: EdgeInsets.a,
      decoration: BoxDecoration(
        color: colorArgs,
        border: Border.all(
          color: colorArgs,
        ),
        shape: BoxShape.circle,
      ),
      // child: whiteSmallText('1'),
      child: child,
    );
  }

  Padding buildSearch() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: ColorSource.gray.withOpacity(0.24),
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: ColorSource.grey1,
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                  color: ColorSource.gray.withOpacity(0.24), width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                  color: ColorSource.gray.withOpacity(0.24), width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                  color: ColorSource.gray.withOpacity(0.24), width: 0),
            ),
            hintText: 'Cari Produk',
            hintStyle: TextStyle(color: ColorSource.grey1),
            labelStyle: TextStyle(color: ColorSource.grey1),
            focusColor: ColorSource.black),
        onChanged: (v) {
          // state.searchData(v);
        },
      ),
    );
  }

  InkWell iconFavorite(Produk produk,
      {double size = 30, required BuildContext context}) {
    return InkWell(
        onTap: () {
          handleTapFavorited(produk, context);
        },
        child: Icon(Icons.favorite,
            size: size,
            color: produk.favorite != null
                ? produk.favorite == 1 //cek
                    ? Colors.pink
                    : Colors.grey
                : Colors.grey));
  }

  Future<void> handleTapFavorited(Produk produk, BuildContext context) async {
    toggleFavorite(produk);

    setColorIconFavorite(context, produk);

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
  }

  void setColorIconFavorite(BuildContext context, Produk produk) {
    context
        .read<ProductProvider>()
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
