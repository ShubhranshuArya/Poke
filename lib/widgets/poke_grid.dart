import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poke_app/features/search/model/poke_list_model.dart';
import 'package:poke_app/widgets/poke_card.dart';

import '../features/detail/screen/poke_detail_screen.dart';

class PokeGrid extends StatelessWidget {
  final PokeListModel pokeList;
  final Widget childCurrent;

  const PokeGrid({
    Key? key,
    required this.pokeList,
    required this.childCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 32.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 32.w,
        mainAxisSpacing: 48.h,
        childAspectRatio: 1.36,
      ),
      itemCount: pokeList.results!.length,
      itemBuilder: (BuildContext context, int index) {
        var pokeResult = pokeList.results![index];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
              child: PokeDetailScreen(id: pokeResult.id),
              childCurrent: childCurrent,
            ),
          ),
          child: PokeCard(
            pokeName: pokeResult.name,
            pokeImageUrl: pokeResult.imageUrl,
            pokeId: pokeResult.id,
          ),
        );
      },
    ).animate().fadeIn();
  }
}
