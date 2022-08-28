import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:test_mobile_apps_dev/data/shared_pref/v_pref.dart';
import 'package:test_mobile_apps_dev/models/user.dart';
import 'package:test_mobile_apps_dev/provider/home_provider.dart';
import 'package:test_mobile_apps_dev/provider/login_provider.dart';
import 'package:test_mobile_apps_dev/provider/product_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/login_page.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_button.dart';
import 'package:test_mobile_apps_dev/ui/widget/v_text.dart';
import 'package:get/get.dart' as get_package;

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<User>(
      future: VPref.getDataUser(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                vText('Developer Information',
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: ColorSource.primaryColor),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            isiDetail('Nama', snapshot.data!.nama),
            SizedBox(
              height: 10,
            ),
            isiDetail('Email', snapshot.data!.email),
            SizedBox(
              height: 10,
            ),
            isiDetail('Telepon', snapshot.data!.telepon),
            SizedBox(
              height: 10,
            ),
            isiDetail('Tanggal Lahir', snapshot.data!.tanggalLahir),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            buildCustomButton(context),
            SizedBox(
              height: 20,
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(
                color: ColorSource.primaryColor,
              ),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      },
    ));
  }

  Widget isiDetail(String title, String des) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lightTextNormal(title),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: mediumText(
            des, //2000149
          ),
        )
      ],
    );
  }

  CustomButton buildCustomButton(BuildContext context) {
    return CustomButton(
      "Logout",
      heightButton: 50,
      outerPaddingHorizontal: 30,
      callback: () async {
        await VPref.clearLoginPreference();
        context.read<HomeProvider>().selectedIndex(
            0); //modify the state home page -> set index tab to 0  (default is left)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ModalRoute.withName('/'));
        // get_package.Get.offAll(LoginPage());
      },
    );
  }
}
