import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../FirebaseHelper/FirebaseStorageService.dart';
import '../../../Objects/CutomerObject.dart';
import '../../../Utils/AppButtons.dart';
import '../../../Utils/AppConstents.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/Images.dart';
import '../../../Utils/ImputDecoration.dart';
import '../../../Utils/Router.dart';
import '../../../Utils/Toast.dart';
import '../../../Utils/dimensions.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController passwordEdtControlor = TextEditingController();

  bool termsConditions = false;
  bool _buttonLoading = false;
  String confirmPassword = '';

  late double screenHeight;
  late double screenWidth;

  final CustomerObject _customer = CustomerObject();

  bool _profileImageLoading = false;
  bool _proofImageLoading = false;
  bool _profileCreatingLoading = false;

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
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 15, right: 15, left: 15, top: 90),
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
                                onSaved: (name) {
                                  setState(() {
                                    _customer.name = name;
                                  });
                                },
                                hintText: 'Username',
                                keyboardType: TextInputType.name,
                                icon: FontAwesomeIcons.circleUser,
                                password: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Username';
                                  }
                                  return null;
                                },
                              ),
                              _singleField(
                                onSaved: (email) {
                                  setState(() {
                                    _customer.email = email;
                                  });
                                },
                                hintText: 'Email Address',
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.alternate_email,
                                password: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Username';
                                  }
                                  return null;
                                },
                              ),
                              _singleField(
                                onSaved: (password) {
                                  setState(() {
                                    _customer.password = password;
                                  });
                                },
                                hintText: 'Choose Password',
                                keyboardType: TextInputType.visiblePassword,
                                icon: FontAwesomeIcons.asterisk,
                                password: true,
                                validator: (value) {
                                  if (value!.isEmpty && value!.length < 8) {
                                    return 'Enter Valid Password';
                                  }
                                  return null;
                                },
                              ),
                              _singleField(
                                onSaved: (password) {
                                  setState(() {
                                    confirmPassword = password!;
                                  });
                                },
                                hintText: 'Confirm Password',
                                keyboardType: TextInputType.visiblePassword,
                                icon: FontAwesomeIcons.asterisk,
                                password: true,
                                validator: (value) {
                                  if (value!.isEmpty && value!.length < 8) {
                                    return 'Enter Valid Password';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      termsConditions = !termsConditions;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        termsConditions
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        size: Dimensions.fontSizeExtraLarge,
                                        color: termsConditions
                                            ? AppThemeColor.darkBlueColor
                                            : AppThemeColor.dullFontColor,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text(
                                        'I agree with ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppThemeColor.dullFontColor,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                      ),
                                      const Text(
                                        'Terms and Conditions.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppThemeColor.darkBlueColor,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _registerCustomer();
                                },
                                child: AppButtons().button1(
                                  labelSize: Dimensions.fontSizeExtraLarge,
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  buttonLoading: _buttonLoading,
                                  label: 'CREATE ACCOUNT',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
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
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppThemeColor.pureWhiteColor,
                              borderRadius: BorderRadius.circular(20),
                              image: _customer.profileImage == null
                                  ? const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        Images.profilePlaceholder,
                                      ),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(_customer.profileImage!.path),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () async {
                                await ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((pickedImage) {
                                  if (pickedImage != null) {
                                    setState(() {
                                      _customer.profileImage = pickedImage;
                                    });
                                    ShowToast().showNormalToast(
                                        msg:
                                            'Profile Image Selected! ${_customer.profileImage!.path.split('/').last}');
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: AppThemeColor.darkBlueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
    required void Function(String?)? onSaved,
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
              onSaved: onSaved,
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
          ),
        ],
      ),
    );
  }

  Future<void> _registerCustomer() async {
    print('${_customer.password} and $confirmPassword');
    try {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        if (termsConditions) {
          if (_customer.password == confirmPassword) {
            if (_customer.profileImage != null) {
              setState(() {
                _buttonLoading = true;
              });
              _key.currentState!.save();
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _customer.email!, password: _customer.password!)
                  .then((customerValue) async {
                setState(() {
                  _customer.uid = customerValue.user!.uid;
                });

                updateUserToFirebaseToFirebase();
                // await AuthFirebaseDatabaseService()
                //     .createNewCustomer(customer: _customer)
                //     .then((done) {
                //   if (done) {
                //     setState(() {
                //       _buttonLoading = false;
                //     });
                //     RouterClass().userHomeScreenRoute(context: context);
                //     ShowToast().showSnackBar(
                //         context: context,
                //         msg: 'Welcome To ${AppConstents.appName}!');
                //   } else {
                //     setState(() {
                //       _buttonLoading = false;
                //     });
                //   }
                // });
              });
            } else {
              ShowToast().showSnackBar(
                  context: context, msg: 'Profile image not attached!');
            }
          } else {
            ShowToast()
                .showSnackBar(context: context, msg: 'Password not match!');
          }
        } else {
          ShowToast().showSnackBar(
              context: context, msg: 'Please check TERMS & CONDITIONS!');
        }
      }
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          ShowToast().showSnackBar(
              context: context, msg: "Email already used. Go to login page.");

          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          ShowToast().showSnackBar(
              context: context, msg: "Wrong email/password combination.");
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          ShowToast().showSnackBar(
              context: context, msg: "No user found with this email.");
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          ShowToast().showSnackBar(context: context, msg: "User disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          ShowToast().showSnackBar(
              context: context,
              msg: "Too many requests to log into this account.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          ShowToast().showSnackBar(
              context: context, msg: "Server error, please try again later.");
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          ShowToast()
              .showSnackBar(context: context, msg: "Email address is invalid.");
          break;
        default:
          ShowToast().showSnackBar(
              context: context, msg: "An undefined Error happened.");
      }
      setState(() {
        _buttonLoading = false;
      });
    } catch (e) {
      setState(() {
        _buttonLoading = false;
      });
    } finally {
      setState(() {
        _buttonLoading = false;
      });
    }
  }

  goBack() {
    Navigator.pop(context);
  }

  Future<void> updateUserToFirebaseToFirebase() async {
    try {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();

        await _uploadingProfileImage();
      }
    } catch (e) {
      setState(() {
        _profileImageLoading = false;
        _proofImageLoading = false;
        _profileCreatingLoading = false;
      });

      print("Update User Error");
      print(e);
    } finally {
      setState(() {
        _profileImageLoading = false;
        _proofImageLoading = false;
        _profileCreatingLoading = false;
      });
    }
  }

  Future<void> _uploadingProfileImage() async {
    String userId = _customer.uid!;

    if (_customer.profileImage != null) {
      setState(() {
        _profileImageLoading = true;
      });
      String userImageName =
          '$userId.${_customer.profileImage!.name.split('.').last}';
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('ProfileImages')
          .child(userImageName);
      await FirebaseStorageService()
          .uploadImage(file: _customer.profileImage!, ref: ref)
          .then((uploadTask) async {
        if (uploadTask != null) {
          await uploadTask.whenComplete(() async {
            await ref.getDownloadURL().then((imageLink) async {
              print('upload done $imageLink');
              setState(() {
                _customer.profileImageLink = imageLink;
                _customer.profileImageName = userImageName;
                _profileImageLoading = false;
              });
              await FirebaseDatabase.instance
                  .ref()
                  .child('Customers')
                  .child(userId)
                  .update(
                    _customer.toJson(),
                  )
                  .then((value) {
                setState(() {
                  _profileCreatingLoading = false;
                });

                RouterClass().userHomeScreenRoute(context: context);
                ShowToast().showSnackBar(
                    context: context,
                    msg: 'Welcome To ${AppConstents.appName}!');
              });

              print(uploadTask.snapshot.bytesTransferred);
            });
          });
        } else {
          setState(() {
            _profileImageLoading = false;
          });
        }
      });
    } else {
      ShowToast()
          .showSnackBar(context: context, msg: 'Please Chose Profile Image!');
    }
  }
}
