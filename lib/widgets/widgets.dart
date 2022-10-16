import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

bool isSplashLoaded = false;

String getPokeId(int id) {
  if (id < 10) {
    return '# 00$id';
  } else if (id < 100) {
    return '# 0$id';
  } else {
    return '# $id';
  }
}

Color getPokeBgColor(String type) {
  switch (type) {
    case 'fire':
      {
        return colorTypeFire;
      }
    case 'water':
      {
        return colorTypeWater;
      }
    case 'electric':
      {
        return colorTypeElectric;
      }
    case 'grass':
      {
        return colorTypeGrass;
      }
    case 'ice':
      {
        return colorTypeIce;
      }
    case 'fighting':
      {
        return colorTypeFighting;
      }
    case 'poison':
      {
        return colorTypePoison;
      }
    case 'ground':
      {
        return colorTypeGround;
      }
    case 'flying':
      {
        return colorTypeFlying;
      }
    case 'psychic':
      {
        return colorTypePsychic;
      }
    case 'bug':
      {
        return colorTypeBug;
      }
    case 'rock':
      {
        return colorTypeRock;
      }
    case 'ghost':
      {
        return colorTypeGhost;
      }
    case 'dragon':
      {
        return colorTypeDragon;
      }
    case 'dark':
      {
        return colorTypeDark;
      }
    case 'steel':
      {
        return colorTypeSteel;
      }
    case 'fairy':
      {
        return colorTypeFairy;
      }
    default:
      {
        return colorTypeNormal;
      }
  }
}

Widget pokeGenerationContainer({required String? imgUrl}) => ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 64.r,
        width: 64.r,
        child: imgUrl != null
            ? Image.network(
                imgUrl,
                fit: BoxFit.contain,
              )
            : const SizedBox.shrink(),
      ),
    );

Widget customAbilitiesContainer({
  required String ability,
  required bool isHidden,
}) =>
    IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: containerBg, width: 2.0),
          color: containerBg.withOpacity(0.2),
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            customText(
              text: ability,
              size: 16,
              color: blackBg,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 16.w),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  isHidden
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: containerBg,
                  size: 20.r,
                ),
              ),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );

Widget customProportionsContainer({
  required String value,
  required String title,
  required String unit,
}) =>
    Container(
      height: 54.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: containerBg, width: 2.0),
        color: containerBg.withOpacity(0.2),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          CircleAvatar(
            radius: 16.r,
            backgroundColor: Colors.white,
            child: Center(
              child: customText(
                text: value,
                size: 10,
                color: containerBg,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: title,
                size: 14,
                color: blackBg,
                fontWeight: FontWeight.w500,
                textHeight: 1,
              ),
              customText(
                text: unit,
                size: 10,
                color: blackBg,
                fontWeight: FontWeight.w300,
                textHeight: 1,
              ),
            ],
          )
        ],
      ),
    );

Widget customText({
  required String text,
  required double size,
  required Color color,
  TextAlign alignment = TextAlign.left,
  FontWeight fontWeight = FontWeight.normal,
  bool isFirstCapital = false,
  double textHeight = 1.4,
}) {
  if (isFirstCapital) {
    text = text[0].toUpperCase() + text.substring(1);
  }
  return Text(
    text,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: size.sp,
      fontWeight: fontWeight,
      height: textHeight,
    ),
    textAlign: alignment,
  );
}
