import 'package:flutter/material.dart';
import 'package:medconnect/Objects/DoctorObject.dart';
import 'package:medconnect/Screens/Appointment/MakeAnApointmentScreen.dart';
import 'package:medconnect/Screens/HomeScreen.dart';
import 'package:medconnect/Screens/SingleDoctorView.dart';
import 'package:medconnect/Screens/SymptomsAccordingDoctors.dart';

import '../Screens/Appointment/ApponitmentSymptomCheckScreen.dart';
import '../Screens/Auth/Screens/ForgetPassword.dart';
import '../Screens/Auth/Screens/LoginScreen.dart';
import '../Screens/Auth/Screens/ProfileScreen.dart';
import '../Screens/Auth/Screens/Registration.dart';
import 'WebViewPage.dart';

class RouterClass {
  appRest({required BuildContext context}) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);

  appRefresh({required BuildContext context}) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false);

  forgetPasswordScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgetPassword(),
        ),
      );

  signupScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Registration(),
        ),
      );

  profileScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );

  userHomeScreenRoute({required BuildContext context}) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );

  webScreen({
    required BuildContext context,
    required String title,
    required String url,
  }) =>
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: url, title: title),
          ));

  loginScreenRoute({required BuildContext context}) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );

  singleDoctorScreenRoute({
    required BuildContext context,
    required DoctorObject doctor,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleDoctorView(
            doctor: doctor,
          ),
        ),
      );

  symptomsAccordingDoctorScreenRoute({
    required BuildContext context,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SymptomsAccordingDoctors(),
        ),
      );

  symptomsCheckerForAppointmentScreenRoute({
    required BuildContext context,
    required DoctorObject doctor,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApponitmentSymptomCheckScreen(
            doctor: doctor,
          ),
        ),
      );

  makeAppointmentScreenRoute({
    required BuildContext context,
    required List<String> symptoms,
    required DoctorObject doctor,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MakeAnApointmentScreen(
            symptoms: symptoms,
            doctor: doctor,
          ),
        ),
      );
  //
  //
}
