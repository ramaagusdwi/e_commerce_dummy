import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_apps_dev/provider/register_provider.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_button.dart';
import 'package:test_mobile_apps_dev/utils/date_picker.dart';
import 'package:test_mobile_apps_dev/utils/utils.dart';
import 'home/home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _tanggalController = TextEditingController();
  bool _isValid = false;
  String _tanggalLahir = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RegisterProvider(context),
      child: SafeArea(
        child: Scaffold(
            body: Padding(
          padding:
              const EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/store.png',
                        height: 60,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'E-Commerce App',
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: ColorSource.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Silahkan daftar dahulu!',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: ColorSource.dark),
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              buildText('Nama'),
              const SizedBox(
                height: 9,
              ),
              buildTextField(_namaController),
              const SizedBox(
                height: 20,
              ),
              buildText('Password'),
              const SizedBox(
                height: 9,
              ),
              buildTextFieldObscure(),
              const SizedBox(
                height: 20,
              ),
              buildText('Email'),
              const SizedBox(
                height: 9,
              ),
              buildTextField(_emailController),
              const SizedBox(
                height: 20,
              ),
              buildText('Telepon'),
              const SizedBox(
                height: 9,
              ),
              buildTextField(_noTelpController),
              const SizedBox(
                height: 20,
              ),
              buildText('Tanggal Lahir'),
              const SizedBox(
                height: 9,
              ),
              buildTextField(_tanggalController,
                  pilihTanggal: true, mystate: setState),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<RegisterProvider>(
                builder: (ctx, register, __) {
                  if (register.state == ResultState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (register.state == ResultState.Failed) {
                    // Get.defaultDialog(title: register.message);
                    Utils.showAlertDialog(
                        register.context, "Gagal", register.message);
                    return SizedBox();
                  } else if (register.state == ResultState.Success) {
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      // Utils.showAlertDialog(ctx, "Success", register.message);
                      Navigator.pushReplacementNamed(ctx, LoginPage.route);
                    });
                    return SizedBox();
                  }
                  return CustomButton(
                    "Register",
                    heightButton: 70,
                    outerPaddingHorizontal: 30,
                    callback: () {
                      //add email validator
                      _isValid = EmailValidator.validate(_emailController.text);
                      if (!_isValid) {
                        Utils.toast(
                          "Enter a Valid Email",
                        );
                      } else if (_emailController.text.isEmpty) {
                        Utils.toast(
                          "Enter Email",
                        );
                      } else if (_passwordController.text.isEmpty) {
                        Utils.toast(
                          "Enter Password",
                        );
                      } else if (_passwordController.text.isEmpty) {
                        Utils.toast(
                          "Enter Password",
                        );
                      } else if (_passwordController.text.isEmpty) {
                        Utils.toast(
                          "Enter Password",
                        );
                      } else if (_namaController.text.isEmpty) {
                        Utils.toast(
                          "Masukan nama!",
                        );
                      } else if (_namaController.text.isEmpty) {
                        Utils.toast(
                          "Masukan telepon!",
                        );
                      } else if (_namaController.text.isEmpty) {
                        Utils.toast(
                          "Masukan tanggal!",
                        );
                      } else {
                        register.onRegister(
                            _namaController.text,
                            _passwordController.text,
                            _emailController.text,
                            _noTelpController.text,
                            _tanggalController.text);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  TextField buildTextFieldObscure() {
    return TextField(
      controller: _passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: ColorSource.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: ColorSource.primaryColor),
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
    );
  }

  Text buildText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: ColorSource.primaryColor),
    );
  }

  TextField buildTextField(TextEditingController controller,
      {bool pilihTanggal = false, StateSetter? mystate}) {
    return TextField(
      controller: controller,
      readOnly: pilihTanggal,
      enableInteractiveSelection: (pilihTanggal) ? false : true,
      onTap: () {
        print("tap!");
        if (pilihTanggal) {
          UtilsWidget.showDatePicker(
              context,
              (value) => mystate!(() {
                    controller.text = value;
                  }));
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: '',
          hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: ColorSource.hintColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: ColorSource.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: ColorSource.primaryColor),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
