import 'package:flutter/material.dart';
import 'package:test_mobile_apps_dev/ui/page/home/home_page.dart';
import 'package:test_mobile_apps_dev/ui/page/login_page.dart';
import 'package:test_mobile_apps_dev/ui/page/register_page.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.route:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RegisterPage.route:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case HomePage.route:
        return MaterialPageRoute(builder: (_) => HomePage());
      // case TicketingDetailPage.routeName:
      //   final args = settings.arguments as TicketingDetailArgument;
      //   return MaterialPageRoute(builder: (_) => TicketingDetailPage(args));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
