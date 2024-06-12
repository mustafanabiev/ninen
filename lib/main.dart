import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/home/service/home_service.dart';
import 'package:ninen/modules/main/cubit/main_cubit.dart';
import 'package:ninen/modules/main/pages/main_page.dart';
import 'package:ninen/modules/onboarding/pages/onboarding_page.dart';
import 'package:ninen/modules/progress/cubit/progress_cubit.dart';
import 'package:ninen/modules/purposes/cubit/purposes_cubit.dart';
import 'package:ninen/modules/setting/cubit/setting_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PurposesCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => HomeCubit(HomeService(prefs: prefs))),
        BlocProvider(create: (context) => ProgressCubit(ImagePicker())),
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: context.read<HomeCubit>().state.auth != null &&
              context.read<HomeCubit>().state.auth!
          ? const MainPage()
          : const OnboardingPage(),
    );
  }
}
