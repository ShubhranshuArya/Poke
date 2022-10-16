import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_app/features/story/model/poke_story_model.dart';
import 'package:poke_app/features/story/screen/poke_story_screen.dart';
import 'package:poke_app/features/story/service/poke_story_service.dart';
import 'package:poke_app/features/story/service/random_poke_list.dart';
import 'package:poke_app/screens/splash_screen.dart';
import 'package:poke_app/widgets/widgets.dart';

import '../../../constants/strings.dart';

class PokeLiquidSwipeScreen extends StatefulWidget {
  const PokeLiquidSwipeScreen({Key? key}) : super(key: key);

  @override
  State<PokeLiquidSwipeScreen> createState() => _PokeLiquidSwipeScreenState();
}

class _PokeLiquidSwipeScreenState extends State<PokeLiquidSwipeScreen> {
  final LiquidController _liquidController = LiquidController();
  final List<PokeStoryModel> _pokeStoryList = [];
  bool _isInitalLoaded = false;

  Future<void> getPokeData() async {
    PokeStoryModel? pokeStoryModel =
        await PokeStoryService().getPokeStory(getRandomVal());
    _pokeStoryList.add(pokeStoryModel!);
  }

  Future<void> refreshPokeData() async {
    for (int i = 0; i < 6; i++) {
      await getPokeData();
    }
  }

  Future<void> getInitialPokeData() async {
    for (int i = 0; i < 10; i++) {
      await getPokeData();
    }
    setState(() {
      _isInitalLoaded = true;
    });
  }

  @override
  void initState() {
    getInitialPokeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isSplashLoaded && !_isInitalLoaded) {
      isSplashLoaded = true;
      return const SplashScreen();
    }
    if (!_isInitalLoaded) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            loadingAnimation,
            height: 120.h,
          ),
        ),
      );
    }
    return LiquidSwipe.builder(
      liquidController: _liquidController,
      itemBuilder: (_, index) {
        return PokeStoryScreen(
          pokeStoryModel: _pokeStoryList[index],
        );
      },
      itemCount: 200,
      enableLoop: false,
      onPageChangeCallback: (pageVal) {
        if (pageVal % 6 == 0) {
          refreshPokeData();
        }
      },
    );
  }
}

int randomNumber() {
  var random = Random();
  int min = 1;
  int max = 900;
  int randVal = min + random.nextInt(max - min);
  return randVal;
}
