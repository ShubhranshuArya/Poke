import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:poke_app/widgets/widgets.dart';

import '../../../constants/colors.dart';

class PokeStatsRow extends StatelessWidget {
  final String text;
  final int value;
  final double percent;
  const PokeStatsRow({
    Key? key,
    required this.text,
    required this.value,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 96.w,
          child: customText(
            text: text,
            size: 16,
            color: blackLite,
          ),
        ),
        SizedBox(
          width: 48.w,
          child: customText(
            text: value.toString(),
            size: 16,
            color: blackMain,
          ),
        ),
        Expanded(
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 12.h,
            percent: getPerCentValue(value),
            backgroundColor: greyMain,
            progressColor: getStatColor(value),
            barRadius: Radius.circular(6.r),
          ),
        ),
        SizedBox(width: 8.h),
      ],
    );
  }

  Color getStatColor(int value) {
    if (value <= 35) {
      return colorChartYellow;
    } else if (value <= 60) {
      return colorChartOrange;
    } else if (value <= 100) {
      return colorChartGreen;
    } else if (value <= 200) {
      return colorChartRed;
    }
    return colorChartPurple;
  }

  double getPerCentValue(int value) {
    if (value <= 35) {
      return generateRandomPercentRange(4, 20);
    } else if (value <= 60) {
      return generateRandomPercentRange(21, 40);
    } else if (value <= 100) {
      return generateRandomPercentRange(41, 60);
    } else if (value <= 200) {
      return generateRandomPercentRange(61, 80);
    }
    return generateRandomPercentRange(81, 100);
  }

  double generateRandomPercentRange(int min, int max) {
    final random = Random();
    int intValue = min + random.nextInt(max - min);
    return intValue / 100;
  }
}
