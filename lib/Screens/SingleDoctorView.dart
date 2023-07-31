import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medconnect/Objects/DoctorObject.dart';
import 'package:medconnect/Utils/AppButtons.dart';
import 'package:medconnect/Utils/AppConstents.dart';
import 'package:medconnect/Utils/Router.dart';

import '../Utils/Colors.dart';
import '../Utils/dimensions.dart';

class SingleDoctorView extends StatefulWidget {
  final DoctorObject doctor;

  const SingleDoctorView({
    super.key,
    required this.doctor,
  });

  @override
  State<SingleDoctorView> createState() => _SingleDoctorViewState();
}

class _SingleDoctorViewState extends State<SingleDoctorView> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  late final DoctorObject _doctor = widget.doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close_rounded,
              color: AppThemeColor.darkBlueColor,
              size: 34,
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              height: _screenWidth / 2,
              width: _screenWidth / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_doctor.profileImageLink!),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _doctor.name!,
                      style: const TextStyle(
                        color: AppThemeColor.darkBlueColor,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _doctor.specialist!,
                          style: const TextStyle(
                            color: AppThemeColor.dullFontColor,
                            fontSize: Dimensions.fontSizeSmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          '(${_doctor.qualification!})',
                          style: const TextStyle(
                            color: AppThemeColor.dullFontColor,
                            fontSize: Dimensions.fontSizeSmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => AppConstents().sendMessageOnWhatsApp(
                    _doctor.phone!,
                    'I got your number from ${AppConstents.appName} i need help!'),
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: AppThemeColor.greenColor,
                  size: 33,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.email,
                color: AppThemeColor.darkBlueColor,
                size: 33,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Clinic:',
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    _doctor.clinicName!,
                    style: const TextStyle(
                      color: AppThemeColor.dullFontColor,
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                _doctor.clinicAddress!,
                style: const TextStyle(
                  color: AppThemeColor.dullFontColor,
                  fontSize: Dimensions.fontSizeSmall,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(
              height: 15,
            ),
          ),
          InkWell(
            onTap: () => RouterClass().symptomsCheckerForAppointmentScreenRoute(
                context: context, doctor: _doctor),
            child: AppButtons().button1(
              width: _screenWidth,
              height: 45,
              buttonLoading: false,
              label: 'Make Appointment',
              labelSize: Dimensions.fontSizeLarge,
            ),
          ),
        ],
      ),
    );
  }
}
