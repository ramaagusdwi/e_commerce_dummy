import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/login_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/page/home/home_page.dart';
import 'package:test_mobile_apps_dev/ui/page/register_page.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_button.dart';
import 'package:test_mobile_apps_dev/utils/utils.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 0, bottom: 0),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/store.png',
                  height: 240,
                ),
                const SizedBox(height: 15),
                Text(
                  'E-Commerce App',
                  style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: ColorSource.textColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 78),
          Text(
            'Username',
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: ColorSource.primaryColor),
          ),
          const SizedBox(height: 9),
          TextField(
            controller: _userNameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: '',
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: ColorSource.hintColor),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: ColorSource.primaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.5, color: ColorSource.primaryColor),
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
          const SizedBox(height: 30),
          Text(
            'Password',
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: ColorSource.primaryColor),
          ),
          SizedBox(height: 9),
          TextField(
            controller: _passwordController,
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: '',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: ColorSource.primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: ColorSource.primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: IconButton(
                color: ColorSource.primaryColor,
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ChangeNotifierProvider(
            create: (_) => LoginProvider(context), //buat objek baru
            child: Consumer<LoginProvider>(
              builder: (ctx, login, __) {
                if (login.state == ResultState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (login.state == ResultState.Failed) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Utils.showAlertDialog(ctx, "Gagal login", login.message);
                  });
                  return buildCustomButton(login);
                } else if (login.state == ResultState.Success) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, HomePage.route);
                    _showMyDialog(ctx);
                  });
                  return const SizedBox();
                }
                return buildCustomButton(login);
              },
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RegisterPage.route);
                // Navigator.pushReplacementNamed(context, HomePage.route);
              },
              child: Text(
                'Belum punya akun?',
                style: TextStyle(
                    color: Colors.grey[850],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  CustomButton buildCustomButton(LoginProvider login) {
    return CustomButton(
      "Login",
      heightButton: 70,
      outerPaddingHorizontal: 30,
      callback: () {
        //add email validator
        if (_userNameController.text.isEmpty) {
          Utils.toast(
            "Enter Email",
          );
        } else if (_passwordController.text.isEmpty) {
          Utils.toast(
            "Enter Password",
          );
        } else {
          log("cek username ${_userNameController.text}, password ${_passwordController.text}");
          login.onLogin(_userNameController.text, _passwordController.text);
        }
      },
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success Login'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Welcome to E-commerce'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
