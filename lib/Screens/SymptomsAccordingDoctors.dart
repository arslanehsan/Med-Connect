import 'package:flutter/material.dart';

import '../FirebaseHelper/FirebaseDatabaseService.dart';
import '../Objects/DoctorObject.dart';
import '../Utils/Colors.dart';
import '../Utils/Router.dart';
import '../Utils/dimensions.dart';

class SymptomsAccordingDoctors extends StatefulWidget {
  const SymptomsAccordingDoctors({super.key});

  @override
  State<SymptomsAccordingDoctors> createState() =>
      _SymptomsAccordingDoctorsState();
}

class _SymptomsAccordingDoctorsState extends State<SymptomsAccordingDoctors> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;
  List<DoctorObject> _doctors = [];

  Future<void> _getDoctors() async {
    await FirebaseDatabaseService().getDoctors().then((doctorsData) {
      if (doctorsData.isNotEmpty) {
        setState(() {
          _doctors = doctorsData;
        });
      }
    });
  }

  @override
  void initState() {
    _getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors According to your Symptom'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: _doctors
                    .map(
                      (singleDoctor) => _singleDoctorView(doctor: singleDoctor),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleDoctorView({required DoctorObject doctor}) {
    double boxWidth = _screenWidth / 2.25;
    return GestureDetector(
      onTap: () => RouterClass().singleDoctorScreenRoute(
        context: context,
        doctor: doctor,
      ),
      child: Container(
        width: boxWidth,
        // color: Colors.transparent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppThemeColor.pureWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: boxWidth,
              height: boxWidth,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppThemeColor.pureWhiteColor,
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(doctor.profileImageLink!),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name!,
                    style: const TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        doctor.specialist!,
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
                        '(${doctor.qualification!})',
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
          ],
        ),
      ),
    );
  }
}
