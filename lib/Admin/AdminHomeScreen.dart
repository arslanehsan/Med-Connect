import 'package:flutter/material.dart';
import 'package:medconnect/Utils/Colors.dart';
import 'package:medconnect/Utils/dimensions.dart';

import 'Router.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Column(
      children: [
        InkWell(
          onTap: () =>
              AdminRouterClass().adminDoctorsScreenRoute(context: context),
          child: _singleMenue(label: 'Doctors'),
        ),
        InkWell(
          onTap: () =>
              AdminRouterClass().adminAppointmentsScreenRoute(context: context),
          child: _singleMenue(label: 'Appointments'),
        ),
      ],
    );
  }

  Widget _singleMenue({required String label}) {
    return Container(
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppThemeColor.dullFontColor1,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontWeight: FontWeight.w700,
              fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppThemeColor.darkBlueColor,
            size: 22,
          ),
        ],
      ),
    );
  }
}
