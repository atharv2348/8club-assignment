import 'package:assignment/screens/experience_selection_screen.dart';
import 'package:assignment/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (BuildContext BuildContext, Widget? context) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Space Grotesk",
              scaffoldBackgroundColor: CustomColors.b1,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: AppBarTheme(color: Colors.white.withOpacity(0.02)),
              iconTheme: const IconThemeData(color: Colors.white)),
          home: ExperienceSelectionScreen(),
        );
      },
    );
  }
}
