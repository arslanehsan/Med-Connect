import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils/Colors.dart';
import '../Utils/Images.dart';
import '../Utils/Router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double screenWidth = 1000;
  double screenHeight = 1000;
  final User? _userData = FirebaseAuth.instance.currentUser;

  late AnimationController logoAnimation;

  _handleAnimation() {
    logoAnimation = AnimationController(
      upperBound: 500,
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    logoAnimation.forward();
    logoAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    _handleAnimation();
    Timer(const Duration(seconds: 3), () {
      _userData != null
          ? RouterClass().userHomeScreenRoute(context: context)
          : RouterClass().loginScreenRoute(
              context: context,
            );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            alignment: Alignment.center,
            child: Image.asset(
              Images.inAppLogo,
              width: logoAnimation.value,
            ),
          ),
        ],
      ),
    );
  }
}
