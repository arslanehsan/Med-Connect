import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';
import '../FirebaseHelper/FirebaseDatabaseService.dart';
import '../Objects/AppSettingsObject.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Images.dart';
import '../Utils/Router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double screenWidth;
  late double screenHeight;

  late bool web;
  AppSettingsObject? _appSettings;

  Future<void> getAppSettings() async {
    await FirebaseDatabaseService().getAppSettings().then((settingsData) {
      if (settingsData != null) {
        setState(() {
          _appSettings = settingsData;
        });
      }
    });
  }

  @override
  void initState() {
    getAppSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    web = screenWidth > 500;
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                height: web ? screenWidth / 4 : screenWidth / 2,
                width: web ? screenWidth / 4 : screenWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Images.inAppLogo),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            _singleValueView(
              title: 'App Name',
              value: AppConstents.appName,
            ),
            const SizedBox(
              height: 20,
            ),
            _singleValueView(
              title: 'App Version',
              value: AppConstents.appVersion,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                thickness: 1,
                color: AppThemeColor.pureWhiteColor,
                endIndent: web ? screenWidth / 4 : screenWidth / 5,
                indent: web ? screenWidth / 4 : screenWidth / 5,
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_appSettings != null) {
                      if (kIsWeb) {
                        AppConstents()
                            .launchURL(url: _appSettings!.aboutUsLink!);
                      } else {
                        RouterClass().webScreen(
                          context: context,
                          title: 'About Us',
                          url: _appSettings!.aboutUsLink!,
                        );
                      }
                    }
                  },
                  child: _singleTabView(
                    iconData: Icons.help_outline,
                    title: 'About Us',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_appSettings != null) {
                      if (kIsWeb) {
                        AppConstents()
                            .launchURL(url: _appSettings!.privacyPolicyLink!);
                      } else {
                        RouterClass().webScreen(
                          context: context,
                          title: 'Privacy Policy',
                          url: _appSettings!.privacyPolicyLink!,
                        );
                      }
                    }
                  },
                  child: _singleTabView(
                    iconData: Icons.policy,
                    title: 'Privacy Policy',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleValueView({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize:
                web ? Dimensions.fontSizeExtraLarge : Dimensions.fontSizeLarge,
            color: AppThemeColor.pureBlackColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize:
                web ? Dimensions.fontSizeExtraLarge : Dimensions.fontSizeLarge,
            color: AppThemeColor.darkBlueColor,
          ),
        ),
      ],
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: web ? 44 : 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: web
                      ? Dimensions.fontSizeExtraLarge
                      : Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
