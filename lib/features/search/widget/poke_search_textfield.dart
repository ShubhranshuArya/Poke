import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poke_app/constants/colors.dart';
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/detail/model/poke_api_detail_model.dart';
import 'package:poke_app/features/search/service/poke_list_service.dart';
import 'package:poke_app/widgets/widgets.dart';

import '../../detail/screen/poke_detail_screen.dart';

class PokeSearchTextfield extends StatefulWidget {
  const PokeSearchTextfield({Key? key}) : super(key: key);

  @override
  State<PokeSearchTextfield> createState() => _PokeSearchTextfieldState();
}

class _PokeSearchTextfieldState extends State<PokeSearchTextfield> {
  final _pokeSearchTextController = TextEditingController();
  PokeApiDetailModel? pokeSearchedDetailModel;
  bool isNotFound = false;

  searchOnEditingComplete() async {
    pokeSearchedDetailModel = await PokeSearchService().searchPokeByNameId(
      searchedText: _pokeSearchTextController.text.trim(),
    );
    if (pokeSearchedDetailModel != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
          child: PokeDetailScreen(id: pokeSearchedDetailModel!.id!),
          // ignore: unnecessary_this
          childCurrent: this.widget,
        ),
      );
      _pokeSearchTextController.clear();
    } else {
      setState(() {
        isNotFound = true;
      });
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isNotFound = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _pokeSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _pokeSearchTextController,
          onEditingComplete: searchOnEditingComplete,
          cursorColor: containerBg,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.r,
                color: containerBg,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.r,
                color: containerBg,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.r,
                color: containerBg,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: containerBg,
            ),
            suffixIcon: GestureDetector(
              onTap: () => _pokeSearchTextController.clear(),
              child: const Icon(
                Icons.clear_rounded,
                color: containerBg,
              ),
            ),
            hintText: 'Try Pikachu or \'669\'',
            hintStyle: GoogleFonts.poppins(
              color: blackLite,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          keyboardType: TextInputType.text,
          style: GoogleFonts.poppins(
            color: blackMain,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        isNotFound
            ? Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: colorChartRed.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: customText(
                      text: noPokeFoundText,
                      size: 12,
                      color: whitePrimary,
                      alignment: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
