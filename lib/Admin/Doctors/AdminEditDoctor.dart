import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../FirebaseHelper/FirebaseStorageService.dart';
import '../../../../Utils/AppButtons.dart';
import '../../../../Utils/Colors.dart';
import '../../../../Utils/ImputDecoration.dart';
import '../../../../Utils/Toast.dart';
import '../../../../Utils/dimensions.dart';
import '../../../Objects/DoctorObject.dart';

class AdminEditDoctor extends StatefulWidget {
  final DoctorObject doctor;
  const AdminEditDoctor({Key? key, required this.doctor}) : super(key: key);

  @override
  State<AdminEditDoctor> createState() => _AdminEditDoctorState();
}

class _AdminEditDoctorState extends State<AdminEditDoctor> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController nameEdtController = TextEditingController();
  TextEditingController emailAddressEdtController = TextEditingController();
  TextEditingController phoneEdtController = TextEditingController();
  TextEditingController specialistEdtController = TextEditingController();
  TextEditingController qualificationEdtController = TextEditingController();
  TextEditingController clinicNameEdtController = TextEditingController();
  TextEditingController clinicAddressEdtController = TextEditingController();

  bool _buttonLoading = false;

  late double screenHeight;
  late double screenWidth;

  late DoctorObject _doctor = widget.doctor;
  XFile? _selectedImage;

  @override
  void initState() {
    nameEdtController.text = _doctor.name!;
    emailAddressEdtController.text = _doctor.email!;
    phoneEdtController.text = _doctor.phone!;
    specialistEdtController.text = _doctor.specialist!;
    qualificationEdtController.text = _doctor.qualification!;
    clinicNameEdtController.text = _doctor.clinicName!;
    clinicAddressEdtController.text = _doctor.clinicAddress!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit ${_doctor.name}',
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
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
                              bottom: 15, right: 15, left: 15, top: 80),
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
                                const SizedBox(
                                  height: 25,
                                ),
                                _singleField(
                                  controller: nameEdtController,
                                  onSaved: (name) {
                                    setState(() {
                                      _doctor.name = name;
                                    });
                                  },
                                  hintText: 'Doctor Name',
                                  keyboardType: TextInputType.name,
                                  icon: FontAwesomeIcons.circleUser,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Doctor Name';
                                    }
                                    return null;
                                  },
                                ),
                                _singleField(
                                  controller: emailAddressEdtController,
                                  onSaved: (email) {
                                    setState(() {
                                      _doctor.email = email;
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
                                  controller: phoneEdtController,
                                  onSaved: (phone) {
                                    setState(() {
                                      _doctor.phone = phone;
                                    });
                                  },
                                  hintText: 'Phone Number',
                                  keyboardType: TextInputType.phone,
                                  icon: Icons.phone_android,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Username';
                                    }
                                    return null;
                                  },
                                ),
                                _singleField(
                                  controller: specialistEdtController,
                                  onSaved: (specialist) {
                                    setState(() {
                                      _doctor.specialist = specialist;
                                    });
                                  },
                                  hintText: 'Specialist',
                                  keyboardType: TextInputType.text,
                                  icon: Icons.tag_faces_sharp,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Specialist';
                                    }
                                    return null;
                                  },
                                ),
                                _singleField(
                                  controller: qualificationEdtController,
                                  onSaved: (qualification) {
                                    setState(() {
                                      _doctor.qualification = qualification;
                                    });
                                  },
                                  hintText: 'Qualification',
                                  keyboardType: TextInputType.text,
                                  icon: Icons.houseboat_sharp,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Qualification';
                                    }
                                    return null;
                                  },
                                ),
                                _singleField(
                                  controller: clinicNameEdtController,
                                  onSaved: (clinicName) {
                                    setState(() {
                                      _doctor.clinicName = clinicName;
                                    });
                                  },
                                  hintText: 'Clinic Name',
                                  keyboardType: TextInputType.text,
                                  icon: FontAwesomeIcons.clinicMedical,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Clinic Name';
                                    }
                                    return null;
                                  },
                                ),
                                _singleField(
                                  controller: clinicAddressEdtController,
                                  onSaved: (clinicAddress) {
                                    setState(() {
                                      _doctor.clinicAddress = clinicAddress;
                                    });
                                  },
                                  hintText: 'Clinic Address',
                                  keyboardType: TextInputType.text,
                                  icon: Icons.share_location_outlined,
                                  password: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Clinic Address';
                                    }
                                    return null;
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    _addNewDoctor();
                                  },
                                  child: AppButtons().button1(
                                    labelSize: Dimensions.fontSizeExtraLarge,
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    buttonLoading: _buttonLoading,
                                    label: 'Update ${_doctor.name}',
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
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
                                borderRadius: BorderRadius.circular(10),
                                image: _selectedImage == null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          _doctor.profileImageLink!,
                                        ),
                                      )
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(_selectedImage!.path),
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
                                        _selectedImage = pickedImage;
                                      });
                                      ShowToast().showNormalToast(
                                          msg: 'Profile Image Selected!');
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
        ],
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
    required TextEditingController controller,
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

  Future<void> _addNewDoctor() async {
    try {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        String userId = _doctor.id!;
        if (_selectedImage != null) {
          setState(() {
            _buttonLoading = true;
          });

          String userImageName =
              '$userId.${_selectedImage!.name.split('.').last}';
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('DoctorProfileImages')
              .child(userImageName);
          await FirebaseStorageService()
              .uploadImage(file: _selectedImage!, ref: ref)
              .then((uploadTask) async {
            if (uploadTask != null) {
              await uploadTask.whenComplete(() async {
                await ref.getDownloadURL().then((imageLink) async {
                  print('upload done $imageLink');
                  setState(() {
                    _doctor.profileImageLink = imageLink;
                    _doctor.profileImageName = userImageName;
                    _doctor.id = userId;
                  });
                  await FirebaseDatabase.instance
                      .ref()
                      .child('Doctors')
                      .child(userId)
                      .update(
                        _doctor.toJson(),
                      )
                      .then((value) {
                    setState(() {
                      _buttonLoading = false;
                    });

                    ShowToast().showSnackBar(
                        context: context, msg: 'Doctor Added Successful!');
                    Navigator.pop(context);
                  });
                  print(uploadTask.snapshot.bytesTransferred);
                  print(uploadTask.snapshot.bytesTransferred);
                });
              });
            } else {
              setState(() {
                _buttonLoading = false;
              });
            }
          });
        } else {
          await FirebaseDatabase.instance
              .ref()
              .child('Doctors')
              .child(userId)
              .update(
                _doctor.toJson(),
              )
              .then((value) {
            setState(() {
              _buttonLoading = false;
            });

            ShowToast().showSnackBar(
                context: context, msg: 'Doctor Updated Successful!');
            Navigator.pop(context);
          });
        }
      }
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
}
