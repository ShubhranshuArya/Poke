import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/internet/internet_cubit/internet_cubit.dart';
import 'package:poke_app/features/internet/screen/no_internet_screen.dart';
import 'package:poke_app/features/search/widget/poke_search_textfield.dart';
import 'package:poke_app/features/search/model/poke_list_model.dart';
import 'package:poke_app/features/search/service/poke_list_service.dart';
import 'package:poke_app/features/story/screen/poke_liquid_swipe_screen.dart';
import 'package:poke_app/widgets/poke_grid.dart';
import 'package:poke_app/widgets/widgets.dart';
import '../../../constants/colors.dart';

class PokeSearchScreen extends StatefulWidget {
  const PokeSearchScreen({Key? key}) : super(key: key);

  @override
  State<PokeSearchScreen> createState() => _PokeSearchScreenState();
}

class _PokeSearchScreenState extends State<PokeSearchScreen> {
  PokeListModel? pokeList;
  bool isDataLoaded = false;

  getPokeList() async {
    pokeList = await PokeSearchService().getPokeContainerList();
    if (pokeList != null) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isDataLoaded = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPokeList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state == InternetState.lost) {
          return const NoInternetScreen();
        }
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: const PokeLiquidSwipeScreen(),
                  childCurrent: widget,
                ),
              ),
              child: Lottie.asset(
                pokeballAnimation,
                height: 60.r,
                animate: isDataLoaded,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 32.h,
                  left: 30.w,
                  right: 30.w,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 300.w,
                              child: customText(
                                text: searchScreenTitleText,
                                size: 24,
                                color: blackMain,
                                textHeight: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: searchScreenDescText,
                              size: 16,
                              color: blackLite,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Search Poke TextField Widget.
                          const PokeSearchTextfield(),
                          SizedBox(height: 16.h),

                          isDataLoaded
                              ? PokeGrid(
                                  pokeList: pokeList!,
                                  childCurrent: widget,
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: 92.h),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.01),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                    !isDataLoaded
                        ? Center(
                            child: Lottie.asset(
                              loadingAnimation,
                              height: 88.h,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
