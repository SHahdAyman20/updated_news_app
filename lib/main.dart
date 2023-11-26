import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:instant_api_news_app/screens/news_main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // AppDio.init();

  runApp(
    DevicePreview(
      builder: (context) => EasyLocalization(
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
        path: 'assets/languages',
        saveLocale: true,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return EasyLocalization(
          path: 'assets/languages', // Add this line
          supportedLocales: const [
            Locale('ar', 'EG'),
            Locale('en', 'US'),
          ],
          fallbackLocale: const Locale('en', 'US'),
          child: MaterialApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            home:const  NewsMainScreen(),
            ),

        );
      },
    );
  }
}