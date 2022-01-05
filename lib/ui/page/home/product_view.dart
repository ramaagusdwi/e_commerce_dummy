import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/product_model.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/cicrle_widget.dart';
import 'package:test_mobile_apps_dev/ui/widget/item_shoes.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  late ProdukModel state;

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider.value(
        // value: ProdukModel(context),
        // child:
        Consumer(
      builder: (BuildContext context, ProdukModel state, Widget? child) {
        print("rebuild widget-produkModel!");
        this.state = state;
        return body(context);
      },
    );
    // );
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
                    : state.aerostreetProductsLocal.isEmpty
                        ? vText("Data tidak ada",
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: ColorSource.black)
                        : Container(
                            // height: 276,
                            height: 230,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.aerostreetProductsLocal.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    ItemShoesCard(
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
                    : state.ardilesProductsLocal.isEmpty
                        ? vText("Data tidak ada",
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: ColorSource.black)
                        : Container(
                            // height: 280,
                            height: 230,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.ardilesProductsLocal.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ItemShoesCard(
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
                    : state.relicaProductsLocal.isEmpty
                        ? vText("Data tidak ada",
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: ColorSource.black)
                        : Container(
                            // height: 280,
                            height: 230,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.relicaProductsLocal.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ItemShoesCard(
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
                    : state.rougheProductLocal.isEmpty
                        ? vText("Data tidak ada",
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: ColorSource.black,
                            align: TextAlign.center)
                        : Container(
                            // height: 280,
                            height: 230,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.rougheProductLocal.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ItemShoesCard(
                                            state.rougheProductLocal[index])),
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
                    : state.vincencioProductsLocal.isEmpty
                        ? vText("Data tidak ada",
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: ColorSource.black,
                            align: TextAlign.center)
                        : Container(
                            // height: 280,
                            height: 230,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.vincencioProductsLocal.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    ItemShoesCard(
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
              child: CircleWidget(
                  child: whiteSmallText('0'),
                  colorArgs: ColorSource.red,
                  size: 20),
            ),
          ],
        ),
      ],
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
          state.runFilter(v);
        },
      ),
    );
  }
}
