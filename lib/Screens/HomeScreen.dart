import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medconnect/FirebaseHelper/FirebaseDatabaseService.dart';
import 'package:medconnect/Objects/CutomerObject.dart';
import 'package:medconnect/Screens/HealthEducation.dart';
import 'package:medconnect/Screens/SettingsScreen.dart';
import 'package:medconnect/Screens/SymptomCheckScreen.dart';
import 'package:medconnect/Utils/Colors.dart';
import 'package:medconnect/Utils/dimensions.dart';

import '../Objects/DoctorObject.dart';
import '../Utils/Router.dart';
import 'Auth/Firebase/FirebaseDatabaseService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  late final double _screenHeight = MediaQuery.of(context).size.height;

  final DateTime todayDate = DateTime.now();

  int bottomNavigationIndex = 0;

  CustomerObject? _customer;
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
    _getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: bottomNavigationIndex == 0
            ? _bodyView()
            : bottomNavigationIndex == 1
                ? const SymptomCheckScreen()
                : bottomNavigationIndex == 2
                    ? HealthEducationListScreen()
                    : const SettingsScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
        currentIndex: bottomNavigationIndex,
        selectedItemColor: AppThemeColor.pureBlackColor,
        selectedIconTheme: const IconThemeData(
          color: AppThemeColor.pureBlackColor,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppThemeColor.dullFontColor,
        ),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Symptoms',
            icon: Icon(
              Icons.coronavirus,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Health',
            icon: Icon(
              Icons.healing,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      decoration: const BoxDecoration(
        gradient: AppThemeColor.backgroundGradient2,
      ),
      child: Column(
        children: [
          _headingView(),
          SingleChildScrollView(
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
        ],
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

  Widget _headingView() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE d MMMM').format(todayDate),
                style: const TextStyle(
                  color: AppThemeColor.pureWhiteColor,
                  fontSize: Dimensions.fontSizeSmall,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: AppThemeColor.pureWhiteColor,
                  fontSize: Dimensions.fontSizeExtraLarge,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (_customer != null)
                InkWell(
                  onTap: () =>
                      RouterClass().profileScreenRoute(context: context),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            _customer!.profileImageLink!,
                          ),
                        )),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
