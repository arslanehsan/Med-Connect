import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medconnect/Utils/AppButtons.dart';

import '../../../Objects/CutomerObject.dart';
import '../../../Utils/AppConstents.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/ImputDecoration.dart';
import '../../../Utils/Router.dart';
import '../../../Utils/dimensions.dart';
import '../Firebase/FirebaseDatabaseService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  // TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController passwordEdtControlor = TextEditingController();

  bool passwordVisible = true;

  bool _buttonLoading = false;
  CustomerObject? _customer;

  Future<void> getProfile() async {
    await AuthFirebaseDatabaseService()
        .getCustomerProfile()
        .then((customerData) {
      if (customerData != null) {
        firstName.text = customerData.name!;
        emailAddress.text = customerData.email!;
        setState(() {
          _customer = customerData;
        });
      }
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  late double _screenWidth = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.backgroundGradient2,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70, left: 15, right: 15),
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 60,
                      bottom: 25,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            AppConstents.appName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppThemeColor.pureBlackColor,
                              fontSize: 33,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          _singleField(
                            controller: firstName,
                            // onSaved: (name) {
                            //   setState(() {
                            //     _customer.name = name;
                            //   });
                            // },
                            hintText: 'Username',
                            keyboardType: TextInputType.name,
                            icon: FontAwesomeIcons.circleUser,
                            password: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter Username';
                              }
                              return null;
                            },
                          ),
                          _singleField(
                            controller: emailAddress,
                            // onSaved: (email) {
                            //   setState(() {
                            //     _customer.email = email;
                            //   });
                            // },
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
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              RouterClass().appRest(context: context);
                            },
                            child: AppButtons().button1(
                              labelSize: Dimensions.fontSizeExtraLarge,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              buttonLoading: _buttonLoading,
                              label: 'LOGOUT',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_customer != null)
                    Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppThemeColor.pureBlackColor,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_customer!.profileImageLink!),
                        ),
                      ),
                    ),
                ],
              )
            ],
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
              enabled: false,
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

  Future showDeleteProfileDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: _dialogView(),
          );
        });
  }

  Widget _dialogView() {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.triangleExclamation,
                size: 50,
                color: AppThemeColor.orangeColor,
              ),
              Text(
                'Hey ${_customer!.name!}\nAre you sure you want to delete your profile?',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextFormField(
                  controller: passwordEdtControlor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passwordVisible,
                  obscuringCharacter: '●',
                  validator: (value) {
                    if (value == null || value!.length < 8) {
                      print('validator called');
                      return 'Enter Valid Password';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: '●●●●●●●●',
                      labelText: 'Password',
                      hintStyle: const TextStyle(
                          color: AppThemeColor.orangeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      labelStyle:
                          const TextStyle(color: AppThemeColor.yellowColor),
                      focusColor: AppThemeColor.yellowColor,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppThemeColor.yellowColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppThemeColor.yellowColor, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          passwordVisible
                              ? setState(() {
                                  passwordVisible = false;
                                })
                              : setState(() {
                                  passwordVisible = true;
                                });
                        },
                        child: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppThemeColor.yellowColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: AppThemeColor.pureBlackColor,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: _deleteProfileCalled,
                      color: AppThemeColor.yellowColor,
                      child: const Text(
                        "M Sure",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteProfileCalled() {
    if (_key.currentState!.validate()) {
      User? currentUserData = FirebaseAuth.instance.currentUser;
      if (currentUserData != null) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: currentUserData.email!,
                password: passwordEdtControlor.text)
            .then((value) {
          currentUserData.delete().then((value) {
            FirebaseAuth.instance.signOut().then((value) {
              RouterClass().appRest(context: context);
            });
          });
        });
      }
    }
  }

  goBack() {
    Navigator.pop(context);
  }
}
