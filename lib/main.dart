import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/features/internet/internet_cubit/internet_cubit.dart';
import 'package:poke_app/features/internet/screen/no_internet_screen.dart';
import 'package:poke_app/features/story/screen/poke_liquid_swipe_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: false,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => InternetCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Poke App',
            home: BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state == InternetState.initial) {
                  return const Scaffold();
                } else if (state == InternetState.gained) {
                  return const PokeLiquidSwipeScreen();
                }
                return const NoInternetScreen();
              },
            ),
          ),
        );
      },
    );
  }
}
