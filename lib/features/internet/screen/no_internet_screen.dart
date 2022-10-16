import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_app/constants/colors.dart';
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/widgets/widgets.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitePrimary,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 110.h),
                child: SizedBox(
                  width: 300.w,
                  child: customText(
                    text: noInternetText,
                    size: 24,
                    color: containerBg,
                    alignment: TextAlign.center,
                    textHeight: 1.2,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 110.h),
                child: Lottie.asset(
                  noInternetAnimation,
                  height: 400.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
