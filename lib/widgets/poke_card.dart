import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import 'widgets.dart';

class PokeCard extends StatelessWidget {
  final String pokeName;
  final String pokeImageUrl;
  final int pokeId;
  const PokeCard({
    Key? key,
    required this.pokeName,
    required this.pokeImageUrl,
    required this.pokeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: containerBg.withOpacity(0.24),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -32,
            child: Image.network(
              pokeImageUrl,
              height: 102.h,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customText(
                text: getPokeId(pokeId),
                size: 10,
                color: blackBg,
                isFirstCapital: true,
                textHeight: 1.4,
              ),
              customText(
                text: pokeName,
                size: 18,
                color: blackBg,
                isFirstCapital: true,
                textHeight: 1.2,
              ),
              SizedBox(height: 12.h)
            ],
          ),
        ],
      ),
    );
  }
}
