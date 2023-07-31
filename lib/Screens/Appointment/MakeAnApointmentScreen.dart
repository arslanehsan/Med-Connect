import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medconnect/Objects/AppointmentObject.dart';
import 'package:medconnect/Objects/DoctorObject.dart';
import 'package:medconnect/Utils/Router.dart';

import '../../../Utils/AppButtons.dart';
import '../../../Utils/AppConstents.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/ImputDecoration.dart';
import '../../../Utils/Toast.dart';
import '../../../Utils/dimensions.dart';
import '../../FirebaseHelper/FirebaseStorageService.dart';
import '../../Objects/CutomerObject.dart';
import '../Auth/Firebase/FirebaseDatabaseService.dart';

class MakeAnApointmentScreen extends StatefulWidget {
  final List<String> symptoms;
  final DoctorObject doctor;

  const MakeAnApointmentScreen({
    Key? key,
    required this.symptoms,
    required this.doctor,
  }) : super(key: key);

  @override
  State<MakeAnApointmentScreen> createState() => _MakeAnApointmentScreenState();
}

class _MakeAnApointmentScreenState extends State<MakeAnApointmentScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // TextEditingController emailAddress = TextEditingController();
  // TextEditingController passwordEdtControlor = TextEditingController();

  bool termsConditions = false;
  bool _buttonLoading = false;
  String confirmPassword = '';

  late double screenHeight;
  late double screenWidth;

  final Appointment _appointment = Appointment();

  CustomerObject? _customer;

  Future<void> getProfile() async {
    await AuthFirebaseDatabaseService()
        .getCustomerProfile()
        .then((customerData) {
      if (customerData != null) {
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
                            'Create an Appointment.',
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
                            onSaved: (description) {
                              setState(() {
                                _appointment.description = description;
                              });
                            },
                            hintText: 'Description note',
                            keyboardType: TextInputType.name,
                            icon: FontAwesomeIcons.circleUser,
                            password: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Description';
                              }
                              return null;
                            },
                          ),
                          InkWell(
                            onTap: () async =>
                                await pickDateAndTime().then((value) {
                              setState(() {
                                _appointment.appointmentDateTime = value;
                              });
                            }),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                        color: AppThemeColor.dullFontColor,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        _appointment.appointmentDateTime != null
                                            ? DateFormat('EEEE d MMMM hh:mm aa')
                                                .format(_appointment
                                                    .appointmentDateTime!)
                                            : 'Appointment Date',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: _appointment
                                                      .appointmentDateTime !=
                                                  null
                                              ? AppThemeColor.pureBlackColor
                                              : AppThemeColor.dullFontColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _appointment.appointmentDateTime != null
                                        ? '(selected)'
                                        : '(not-selected)',
                                    style: const TextStyle(
                                      color: AppThemeColor.dullFontColor1,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => _pickAttachment(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_file,
                                        color: AppThemeColor.dullFontColor,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Attach Reports (Optional)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: _appointment.reportFile != null
                                              ? AppThemeColor.pureBlackColor
                                              : AppThemeColor.dullFontColor,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _appointment.reportFile != null
                                        ? '(attached)'
                                        : '(un-attached)',
                                    style: const TextStyle(
                                      color: AppThemeColor.dullFontColor1,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _makeAppointment();
                            },
                            child: AppButtons().button1(
                              labelSize: Dimensions.fontSizeExtraLarge,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              buttonLoading: _buttonLoading,
                              label: 'Make an Appointment',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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

  Future<DateTime?> pickDateAndTime() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // Show the date picker dialog
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 1), // Limit selection to one year from today
    ).then((pickedDate) {
      if (pickedDate != null) {
        selectedDate = pickedDate;
      }
    });

    // Show the time picker dialog
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime != null) {
        selectedTime = pickedTime;
      }
    });

    if (selectedDate != null && selectedTime != null) {
      return DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    }

    return null;
  }

  void _pickAttachment() {
    FilePicker.platform.pickFiles().then((value) {
      if (value != null) {
        setState(() {
          _appointment.reportFile = File(value.files.single.path!);
        });
      }
    });
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

  Future<void> _makeAppointment() async {
    try {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        if (_appointment.appointmentDateTime != null) {
          setState(() {
            _buttonLoading = true;
          });
          _appointment.appointmentId =
              FirebaseDatabase.instance.ref().child('Appointments').push().key;
          _appointment.doctorId = widget.doctor.id;
          _appointment.doctorName = widget.doctor.name;
          _appointment.customerId = _customer!.uid!;
          _appointment.customerName = _customer!.name!;
          _appointment.symptomsList = widget.symptoms;

          if (_appointment.reportFile != null) {
            String appointmentImageName =
                '$_appointment.appointmentId.${_appointment.reportFile!.path.split('.').last}';
            Reference ref = FirebaseStorage.instance
                .ref()
                .child('Reports')
                .child(appointmentImageName);
            await FirebaseStorageService()
                .uploadFile(file: _appointment.reportFile!, ref: ref)
                .then((uploadTask) async {
              if (uploadTask != null) {
                await uploadTask.whenComplete(() async {
                  await ref.getDownloadURL().then((imageLink) async {
                    print('upload done $imageLink');
                    setState(() {
                      _appointment.reportFileLink = imageLink;
                      _appointment.reportFileName = appointmentImageName;
                    });

                    await FirebaseDatabase.instance
                        .ref()
                        .child('Appointments')
                        .child(_appointment.appointmentId!)
                        .update(
                          _appointment.toJson(),
                        )
                        .then((value) {
                      setState(() {
                        _buttonLoading = false;
                      });
                      ShowToast().showSnackBar(
                          context: context, msg: 'Appointment Submitted!');
                      RouterClass().appRefresh(context: context);
                    });
                    print(uploadTask.snapshot.bytesTransferred);
                  });
                });
              }
            });
          } else {
            _appointment.reportFileName = 'none';
            _appointment.reportFileLink = 'none';

            await FirebaseDatabase.instance
                .ref()
                .child('Appointments')
                .child(_appointment.appointmentId!)
                .update(
                  _appointment.toJson(),
                )
                .then((value) {
              print('m called');
              setState(() {
                _buttonLoading = false;
              });

              ShowToast().showSnackBar(
                  context: context, msg: 'Appointment Submitted!');
            });
          }
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
