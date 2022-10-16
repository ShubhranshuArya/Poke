import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/constants/colors.dart';
import 'package:poke_app/constants/strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 120.h),
              child: Center(child: Image.asset(pokeSplashGif)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: Center(
                child: Image.asset(
                  pokeSplashImage,
                  width: 300.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
