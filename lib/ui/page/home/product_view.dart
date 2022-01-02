import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/provider/favorite_model.dart';
import 'package:test_mobile_apps_dev/provider/product_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_box_container.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  late ProdukModel state;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProdukModel(context),
      child: Consumer(
        builder: (BuildContext context, ProdukModel state, Widget? child) {
          print("rebuild produkModel!");
          this.state = state;
          return body(context);
        },
      ),
    );
    // return body(context);
  }

  Scaffold body(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCustomAppBar(context),
                const SizedBox(
                  height: 16,
                ),
                buildSearch(),
                const SizedBox(
                  height: 20,
                ),
                normalText('Aerostreet'),
                const SizedBox(
                  height: 4,
                ),
                state.state == ResultState.Loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorSource.primaryColor,
                      ))
                    : Container(
                        // height: 276,
                        height: 230,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                itemCardShoes(
                                    state.aerostreetProductsLocal[index])),
                      ),
                const SizedBox(
                  height: 16,
                ),
                normalText('Ardiles Culture'),
                const SizedBox(
                  height: 4,
                ),
                state.state == ResultState.Loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorSource.primaryColor,
                      ))
                    : Container(
                        // height: 280,
                        height: 230,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                itemCardShoes(
                                    state.ardilesProductsLocal[index])),
                      ),
                const SizedBox(
                  height: 16,
                ),
                normalText('Relica'),
                const SizedBox(
                  height: 4,
                ),
                state.state == ResultState.Loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorSource.primaryColor,
                      ))
                    : Container(
                        // height: 280,
                        height: 230,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                itemCardShoes(
                                    state.relicaProductsLocal[index])),
                      ),
                const SizedBox(
                  height: 16,
                ),
                normalText('Roughe'),
                const SizedBox(
                  height: 4,
                ),
                state.state == ResultState.Loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorSource.primaryColor,
                      ))
                    : Container(
                        // height: 280,
                        height: 230,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                itemCardShoes(state.rougheProductLocal[index])),
                      ),
                const SizedBox(
                  height: 16,
                ),
                normalText('Vincencio'),
                const SizedBox(
                  height: 4,
                ),
                state.state == ResultState.Loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorSource.primaryColor,
                      ))
                    : Container(
                        // height: 280,
                        height: 230,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                itemCardShoes(
                                    state.vincencioProductsLocal[index])),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildCustomAppBar(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(child: titleTextBig("Product List"))),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.shopping_cart,
              color: ColorSource.primaryColor,
              size: 24.0,
            ),
            Positioned(
              top: -10,
              right: -8,
              child: buildCircle(
                  child: whiteSmallText('0'),
                  colorArgs: ColorSource.red,
                  size: 20),
            ),
          ],
        ),
      ],
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

  Widget itemCardShoes(Produk data) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: MediaQuery.of(state.context).size.width *
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
                    width: 160,
                    height: 140,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff7c94b6),
                      image: DecorationImage(
                        image: AssetImage('assets/image/${data.pathImage}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
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
                      child: iconFavorite(data, size: 30))
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
                    const Text(
                      "Dummy Brand",
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
                    const SizedBox(
                      height: 3,
                    ),
                    // iconFavorite(data)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell iconFavorite(Produk data, {double size = 30}) {
    return InkWell(
        onTap: () {
          // state.setFavorite(data);
          state.context.read<FavoriteModel>().setFavorite(data);
        },
        child: Icon(Icons.favorite,
            size: size,
            color: data.favorite != null
                ? data.favorite == 1 //cek
                    ? Colors.pink
                    : Colors.grey
                : Colors.grey));
  }
}
