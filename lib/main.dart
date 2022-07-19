import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/common/navigation.dart';
import 'package:test_mobile_apps_dev/provider/favorite_model.dart';
import 'package:test_mobile_apps_dev/provider/home_model.dart';
import 'package:test_mobile_apps_dev/provider/product_model.dart';
import 'package:test_mobile_apps_dev/provider/register_model.dart';
import 'package:test_mobile_apps_dev/router/routing.dart';
import 'package:test_mobile_apps_dev/ui/page/home/home_page.dart';
import 'package:test_mobile_apps_dev/ui/page/product_detail_page.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterModel(context),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteModel(context),
        ),
        ChangeNotifierProvider(
          create: (_) => ProdukModel(context),
        )
      ],
      child: MaterialApp(
        title: 'Dummy Mobile E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.route,
        onGenerateRoute: Routing.generateRoute,
        routes: {
          ProductDetailPage.route: (context) => ProductDetailPage(),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
