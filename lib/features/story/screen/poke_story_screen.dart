import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poke_app/constants/colors.dart';
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/detail/screen/poke_detail_screen.dart';
import 'package:poke_app/features/internet/internet_cubit/internet_cubit.dart';
import 'package:poke_app/features/internet/screen/no_internet_screen.dart';
import 'package:poke_app/features/search/screen/poke_search_screen.dart';
import 'package:poke_app/features/story/model/poke_story_model.dart';
import 'package:poke_app/widgets/widgets.dart';

class PokeStoryScreen extends StatefulWidget {
  final PokeStoryModel pokeStoryModel;
  const PokeStoryScreen({
    Key? key,
    required this.pokeStoryModel,
  }) : super(key: key);

  @override
  State<PokeStoryScreen> createState() => _PokeStoryScreenState();
}

class _PokeStoryScreenState extends State<PokeStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state == InternetState.lost) {
          return const NoInternetScreen();
        }
        return Scaffold(
          backgroundColor:
              getPokeBgColor(widget.pokeStoryModel.types[0].type.name),
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 400,
                    width: 320,
                    child: Center(
                      child: Image.network(widget.pokeStoryModel.imageUrl),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.h,
                    left: 30.w,
                    right: 30.w,
                    bottom: 24.h,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: customText(
                              text: getPokeId(widget.pokeStoryModel.id),
                              size: 20,
                              color: whitePrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushReplacement(
                                PageTransition(
                                  type: PageTransitionType.topToBottomPop,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease,
                                  child: const PokeSearchScreen(),
                                  childCurrent: widget,
                                ),
                              ),
                              child: Icon(
                                Icons.clear_rounded,
                                size: 32.r,
                                color: whitePrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      customText(
                        text: widget.pokeStoryModel.name,
                        size: 32,
                        color: whitePrimary,
                        fontWeight: FontWeight.w600,
                        isFirstCapital: true,
                        alignment: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                            child:
                                PokeDetailScreen(id: widget.pokeStoryModel.id),
                            childCurrent: widget,
                          ),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: whitePrimary,
                          size: 64.r,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
