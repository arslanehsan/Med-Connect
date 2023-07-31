import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Utils/AppButtons.dart';
import '../../../Utils/AppConstents.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/ImputDecoration.dart';
import '../../../Utils/Router.dart';
import '../../../Utils/Toast.dart';
import '../../../Utils/dimensions.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailAddress = TextEditingController();
  bool _buttonLoading = false;
  late double screenWidth, screenHeight;

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
                      key: key,
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
                            'Create an Account.',
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
                            hintText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.alternate_email,
                            password: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter Username';
                              }
                              return null;
                            },
                          ),
                          InkWell(
                            onTap: () async {
                              if (!_buttonLoading) {
                                if (key.currentState!.validate()) {
                                  setState(() {
                                    _buttonLoading = true;
                                  });
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: emailAddress.text)
                                      .then((value) {
                                    setState(() {
                                      _buttonLoading = false;
                                    });
                                    ShowToast().showSnackBar(
                                      context: context,
                                      msg: 'Please Check Your Email!',
                                    );
                                    RouterClass().appRest(context: context);
                                  });
                                }
                              }
                            },
                            child: AppButtons().button1(
                              labelSize: Dimensions.fontSizeDefault,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              buttonLoading: _buttonLoading,
                              label: 'SEND RECOVERY INSTRUCTIONS',
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
                              GestureDetector(
                                onTap: () => Navigator.of(context),
                                child: const Text(
                                  'Sign In Account',
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

  goBack() {
    Navigator.pop(context);
  }
}
