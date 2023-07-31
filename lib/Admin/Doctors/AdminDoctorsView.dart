import 'package:flutter/material.dart';
import 'package:medconnect/Admin/AdminFirebaseHelper/AdminFirebaseDatabaseService.dart';
import 'package:medconnect/Admin/Router.dart';
import 'package:medconnect/Utils/Colors.dart';
import 'package:medconnect/Utils/dimensions.dart';

import '../../Objects/DoctorObject.dart';
import '../../Utils/Images.dart';

class AdminDoctorsScreen extends StatefulWidget {
  const AdminDoctorsScreen({super.key});

  @override
  State<AdminDoctorsScreen> createState() => _AdminDoctorsScreenState();
}

class _AdminDoctorsScreenState extends State<AdminDoctorsScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  String deleting = '';
  List<DoctorObject> _doctors = [];

  Future<void> _getDoctors() async {
    await AdminFirebaseDatabaseService().getDoctors().then((doctorsData) {
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
        title: const Text('Doctors'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemeColor.darkBlueColor,
        onPressed: () async => await AdminRouterClass()
            .adminAddNewDoctorScreenRoute(context: context)
            .then(() {
          _getDoctors();
        }),
        child: const Icon(
          Icons.add,
          color: AppThemeColor.pureWhiteColor,
          size: 30,
        ),
      ),
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
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
    );
  }

  Widget _singleDoctorView({required DoctorObject doctor}) {
    double boxWidth = _screenWidth / 2.2;
    return GestureDetector(
      onTap: () async => await AdminRouterClass()
          .adminEditDoctorScreenRoute(
        context: context,
        doctor: doctor,
      )
          .then(() {
        _getDoctors();
      }),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          deleting = doctor.id!;
                        });
                        await AdminFirebaseDatabaseService()
                            .deleteDoctor(doctor: doctor)
                            .then((done) {
                          if (done) {
                            setState(() {
                              _doctors.remove(doctor);
                              deleting = '';
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppThemeColor.cardBackGroundColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: deleting != doctor.id!
                            ? const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              )
                            : Image.asset(
                                Images.loading,
                                width: 20,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
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
