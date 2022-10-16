import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:poke_app/constants/colors.dart';
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/detail/model/poke_api_detail_model.dart';
import 'package:poke_app/features/detail/model/poke_dex_api_detail_model.dart';
import 'package:poke_app/features/detail/service/poke_detail_service.dart';
import 'package:poke_app/features/detail/widget/poke_stats_row.dart';
import 'package:poke_app/features/internet/internet_cubit/internet_cubit.dart';
import 'package:poke_app/features/internet/screen/no_internet_screen.dart';
import 'package:poke_app/widgets/widgets.dart';

class PokeDetailScreen extends StatefulWidget {
  final int id;
  const PokeDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  PokeApiDetailModel? pokeDetailModel;
  PokeDexApiDetailModel? pokeDexApiDetailModel;
  bool isDataLoaded = false;
  bool isAllPressed = false;
  bool isaboutFound = false;

  getPokeData() async {
    List<PokeDexApiDetailModel>? pokeDexApiDetailList =
        await PokeDetailService().getDetailFromPokeDexApi(widget.id);
    pokeDexApiDetailModel =
        pokeDexApiDetailList != null ? pokeDexApiDetailList[0] : null;
    pokeDetailModel = await PokeDetailService().getDetailFromPokeApi(widget.id);
    if (pokeDetailModel != null) {
      setState(() {
        if (pokeDexApiDetailModel != null) {
          isaboutFound = true;
        }
        isDataLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPokeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state == InternetState.lost) {
          return const NoInternetScreen();
        }
        return Scaffold(
          body: SafeArea(
            child: !isDataLoaded
                ? Center(
                    child: Lottie.asset(
                      loadingAnimation,
                      height: 120.h,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                        right: 30.w,
                      ),
                      child: Column(
                        children: [
                          // App bar row with back, pokedex, like
                          _appBarRow(),
                          SizedBox(height: 24.h),
                          // Poke image carousel.
                          _imageShowContainer(),
                          SizedBox(height: 24.h),
                          customText(
                            text: pokeDetailModel!.name!,
                            size: 24,
                            color: blackMain,
                            isFirstCapital: true,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 8.h),
                          _pokeTypeChipList(),
                          SizedBox(height: 24.h),
                          isaboutFound
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: customText(
                                    text: 'About',
                                    size: 20,
                                    color: blackMain,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: isaboutFound ? 8.h : 0),
                          isaboutFound
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: customText(
                                    text: pokeDexApiDetailModel!.description!,
                                    size: 16,
                                    color: blackLite,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: isaboutFound ? 24.h : 0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: 'Stats',
                              size: 20,
                              color: blackMain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Poke Stats Column
                          _pokeStatsColumn(),
                          SizedBox(height: 24.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: 'Proportions',
                              size: 20,
                              color: blackMain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Pokemon height and weight view.
                          _pokeProportionsRow(),
                          SizedBox(height: 24.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: 'Experience Gained',
                              size: 20,
                              color: blackMain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _experienceGainedRow(),
                          SizedBox(height: 24.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: 'Abilities',
                              size: 20,
                              color: blackMain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Pokemon Abilities list view.
                          _pokeAbilitiesList(),
                          SizedBox(height: 24.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                              text: 'Sprites',
                              size: 20,
                              color: blackMain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Sprites for all 8 generations column.
                          _spiritesColumn(),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _appBarRow() => Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: customText(
              text: getPokeId(widget.id),
              size: 22,
              color: blackMain,
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 28.r,
              ),
            ),
          ),
        ],
      );

  Widget _imageShowContainer() {
    List<String> pokeImgUrlList = [];
    if (pokeDetailModel!.sprites!.other!.officialArtwork!.frontDefault !=
        null) {
      pokeImgUrlList
          .add(pokeDetailModel!.sprites!.other!.officialArtwork!.frontDefault!);
    }
    if (pokeDetailModel!.sprites!.other!.home!.frontDefault != null) {
      pokeImgUrlList.add(pokeDetailModel!.sprites!.other!.home!.frontDefault!);
    }
    if (pokeDetailModel!.sprites!.other!.dreamWorld!.frontDefault != null) {
      pokeImgUrlList
          .add(pokeDetailModel!.sprites!.other!.dreamWorld!.frontDefault!);
    }
    return CarouselSlider(
      items: pokeImgUrlList
          .map((imgUrl) => Container(
                child: (imgUrl.endsWith('svg'))
                    ? SvgPicture.network(
                        imgUrl,
                      )
                    : Image.network(imgUrl),
              ))
          .toList(),
      options: CarouselOptions(
        height: 258.h,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _pokeTypeChipList() {
    List<String> pokeTypes = [];
    for (var pokeType in pokeDetailModel!.types!) {
      pokeTypes.add(pokeType.type!.name!);
    }

    return Wrap(
      spacing: 8.w,
      children: pokeTypes
          .map(
            (type) => Chip(
              backgroundColor: getPokeBgColor(type).withOpacity(0.2),
              side: BorderSide(
                color: getPokeBgColor(type),
                width: 2,
              ),
              label: customText(
                text: type,
                size: 12,
                color: getPokeBgColor(type),
                fontWeight: FontWeight.bold,
                isFirstCapital: true,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _pokeStatsColumn() {
    return Column(
      children: [
        // min - 1, max - 255, avg - 68-80
        PokeStatsRow(
          text: 'HP',
          value: pokeDetailModel!.stats![0].baseStat!,
          percent: 0.5,
        ),
        SizedBox(height: 8.h),
        // min - 5, max - 190, avg 75-90
        PokeStatsRow(
            text: 'Attack',
            value: pokeDetailModel!.stats![1].baseStat!,
            percent: 0.6),
        SizedBox(height: 8.h),
        // min - 5, max - 250, avg 73-83
        PokeStatsRow(
            text: 'Defence',
            value: pokeDetailModel!.stats![2].baseStat!,
            percent: 0.4),
        SizedBox(height: 8.h),
        // min - 10, max - 194, avg 69-83
        PokeStatsRow(
            text: 'Sp. Atk',
            value: pokeDetailModel!.stats![3].baseStat!,
            percent: 0.3),
        SizedBox(height: 8.h),
        // min - 20, max - 250, avg 69-83
        PokeStatsRow(
            text: 'Sp. Def',
            value: pokeDetailModel!.stats![4].baseStat!,
            percent: 0.9),
        SizedBox(height: 8.h),
        // min - 5, max - 200, avg 66-78
        PokeStatsRow(
            text: 'Speed',
            value: pokeDetailModel!.stats![5].baseStat!,
            percent: 0.1),
      ],
    );
  }

  Widget _pokeProportionsRow() {
    double weight = pokeDetailModel!.weight! / 10;
    double height = pokeDetailModel!.height! / 10;
    return Row(
      children: [
        Expanded(
          child: customProportionsContainer(
            value: '$weight',
            title: 'Weight',
            unit: 'Kg',
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: customProportionsContainer(
            value: '$height',
            title: 'Height',
            unit: 'M',
          ),
        ),
      ],
    );
  }

  Widget _experienceGainedRow() {
    // min 20, max 390, avg
    int? value = pokeDetailModel!.baseExperience;
    Color getChartColor(int value) {
      if (value <= 75) {
        return colorChartYellow;
      } else if (value <= 120) {
        return colorChartGreen;
      } else if (value <= 220) {
        return colorChartRed;
      } else {
        return colorChartPurple;
      }
    }

    double getChartPercent(int value) {
      if (value <= 75) {
        return 0.2;
      } else if (value <= 120) {
        return 0.4;
      } else if (value <= 220) {
        return 0.6;
      } else {
        return 0.8;
      }
    }

    return Column(
      children: [
        SizedBox(height: 8.h),
        CircularPercentIndicator(
          radius: 64.r,
          lineWidth: 10.0,
          percent: value == null ? 0 : getChartPercent(value),
          center: customText(
            text: value == null ? "NA" : value.toString(),
            size: 32,
            color: blackLite,
          ),
          backgroundColor: greyMain,
          progressColor:
              value == null ? Colors.transparent : getChartColor(value),
        ),
        SizedBox(height: 16.h),
        customText(
          text: '$experienceGainedText${pokeDetailModel!.name}.',
          size: 16,
          color: blackLite,
          alignment: TextAlign.left,
        ),
      ],
    );
  }

  Widget _pokeAbilitiesList() {
    List<Ability> abilitiesList = pokeDetailModel!.abilities;
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 54.h,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: abilitiesList.length,
          itemBuilder: (_, int index) {
            String abilityRaw = abilitiesList[index].ability!.name!;

            bool isHidden = abilitiesList[index].isHidden!;
            return customAbilitiesContainer(
              ability: abilityRaw[0].toUpperCase() + abilityRaw.substring(1),
              isHidden: isHidden,
            );
          },
          separatorBuilder: (_, int index) => SizedBox(
            width: 12.w,
          ),
        ),
      ),
    );
  }

  Widget generationRow({
    required String genRoman,
    String? img1,
    String? img2,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(
            text: 'Generation - $genRoman',
            size: 16,
            color: blackLite,
          ),
          Row(
            children: [
              pokeGenerationContainer(imgUrl: img2),
              SizedBox(width: 16.h),
              pokeGenerationContainer(imgUrl: img1),
            ],
          )
        ],
      );

  Widget _spiritesColumn() {
    var img = pokeDetailModel!.sprites!.versions;
    return Column(
      children: [
        generationRow(
          genRoman: 'VIII',
          img1: img!.generationViii!.icons!.frontDefault,
          img2: img.generationVi!.xy!.frontDefault,
        ),
        SizedBox(height: 16.h),
        generationRow(
          genRoman: 'VII',
          img1: img.generationVii!.icons!.frontDefault,
          img2: img.generationVii!.ultraSunUltraMoon!.frontDefault,
        ),
        SizedBox(height: isAllPressed ? 16.h : 24.h),
        Visibility(
          visible: !isAllPressed,
          child: IntrinsicWidth(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAllPressed = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48.h),
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: viewMoreBg,
                ),
                child: Center(
                  child: customText(
                    text: 'View More',
                    size: 18,
                    color: whitePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isAllPressed ? 0 : 24.h),
        Visibility(
          visible: isAllPressed,
          child: Column(
            children: [
              generationRow(
                genRoman: 'VI',
                img1: img.generationVi!.omega!.frontDefault,
                img2: img.generationVi!.xy!.frontDefault,
              ),
              SizedBox(height: 16.h),
              generationRow(
                genRoman: 'V',
                img1: img.generationV!.blackWhite!.frontDefault,
              ),
              SizedBox(height: 16.h),
              generationRow(
                genRoman: 'IV',
                img1: img.generationIv!.platinum!.frontDefault,
                img2: img.generationIv!.diamondPearl!.frontDefault,
              ),
              SizedBox(height: 16.h),
              generationRow(
                genRoman: 'III',
                img1: img.generationIii!.emerald!.frontDefault,
                img2: img.generationIii!.rubySapphire!.frontDefault,
              ),
              SizedBox(height: 16.h),
              generationRow(
                genRoman: 'II',
                img1: img.generationIi!.crystal!.frontDefault,
                img2: img.generationIi!.gold!.frontDefault,
              ),
              SizedBox(height: 16.h),
              generationRow(
                genRoman: 'I',
                img1: img.generationI!.redBlue!.frontDefault,
                img2: img.generationI!.yellow!.frontDefault,
              ),
            ],
          ),
        ),
        SizedBox(height: isAllPressed ? 24.h : 0),
        Visibility(
          visible: isAllPressed,
          child: IntrinsicWidth(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAllPressed = false;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48.h),
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: viewMoreBg,
                ),
                child: Center(
                  child: customText(
                    text: 'View Less',
                    size: 18,
                    color: whitePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isAllPressed ? 24.h : 0.h),
      ],
    );
  }
}
