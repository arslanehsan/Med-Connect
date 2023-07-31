// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medconnect/Utils/AppButtons.dart';
import 'package:medconnect/Utils/AppConstents.dart';
import 'package:medconnect/Utils/dimensions.dart';

import '../../../Utils/Colors.dart';
import '../../../Utils/ImputDecoration.dart';
import '../../../Utils/Router.dart';
import '../../../Utils/Toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey();

  bool buttonLoading = false;
  bool remember = false;
  late double screenHeight;
  late double screenWidth;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController passwordEdtControlor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.backgroundGradient2,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppConstents.appName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppThemeColor.pureBlackColor,
                              fontSize: 33,
                            ),
                          ),
                          const Text(
                            'Login to your Account.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppThemeColor.dullFontColor,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          _singleField(
                            controller: emailAddress,
                            hintText: 'Username',
                            keyboardType: TextInputType.emailAddress,
                            icon: FontAwesomeIcons.circleUser,
                            password: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter Email';
                              } else if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value)) {
                                return "Please Enter a Valid Email";
                              }
                              return null;
                            },
                          ),
                          _singleField(
                            controller: passwordEdtControlor,
                            hintText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            icon: FontAwesomeIcons.asterisk,
                            password: true,
                            validator: (value) {
                              if (value == null && value!.length < 8) {
                                return 'Enter Valid Password';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  remember = !remember;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    remember
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    size: Dimensions.fontSizeExtraLarge,
                                    color: remember
                                        ? AppThemeColor.darkBlueColor
                                        : AppThemeColor.dullFontColor,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    'Remember this Account.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppThemeColor.dullFontColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _loginCustomer();
                            },
                            child: AppButtons().button1(
                              labelSize: Dimensions.fontSizeExtraLarge,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              buttonLoading: buttonLoading,
                              label: 'SIGN IN',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => RouterClass()
                                    .forgetPasswordScreenRoute(
                                        context: context),
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSizeSmall,
                                    fontWeight: FontWeight.w400,
                                    color: AppThemeColor.dullFontColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => RouterClass()
                                    .signupScreenRoute(context: context),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSizeSmall,
                                    fontWeight: FontWeight.w400,
                                    color: AppThemeColor.dullFontColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleField({
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required String hintText,
    required TextInputType keyboardType,
    required IconData icon,
    required bool password,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppThemeColor.lightGrayColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              obscureText: password,
              keyboardType: keyboardType,
              decoration: InputDecorations.decoration1(
                hintText: hintText,
                labelText: null,
                icon: icon,
              ),
            ),
          ),
          const Text(
            '(required)',
            style: TextStyle(
              color: AppThemeColor.dullFontColor1,
              fontSize: Dimensions.fontSizeSmall,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _loginCustomer() async {
    try {
      if (_key.currentState!.validate()) {
        String email = emailAddress.text, password = passwordEdtControlor.text;
        setState(() {
          buttonLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((customer) {
          setState(() {
            buttonLoading = false;
          });
          RouterClass().userHomeScreenRoute(context: context);
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          ShowToast().showNormalToast(
              msg: "Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          ShowToast().showNormalToast(msg: "Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          ShowToast()
              .showNormalToast(msg: "User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          ShowToast()
              .showNormalToast(msg: "User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          ShowToast()
              .showNormalToast(msg: "Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          ShowToast().showNormalToast(
              msg: "Signing in with Email and Password is not enabled.");
          break;
        default:
          ShowToast().showNormalToast(msg: "An undefined Error happened.");
      }
      setState(() {
        buttonLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        buttonLoading = false;
      });
    }
  }
}
