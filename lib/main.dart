import 'package:animations/pages/color_animation.dart';
import 'package:animations/pages/place_anim.dart';
import 'package:animations/routes/app_pages.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async{
  ///Ensure the widgets are already initialized
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  /// init screen util
  await ScreenUtil.ensureScreenSize();

  /// force transparent top bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  /// force portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: ScreenUtilInit(
        designSize: const Size(1080, 1920),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          title: 'Flutter Animations',
          showSemanticsDebugger: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          //getPages: AppPages.appPages,
          //initialRoute: AppRoutes.mainPage,
          home: ExpandableNavBar(),
          supportedLocales: const [Locale('en', 'US')],
          defaultTransition: Transition.fade,
          transitionDuration: 300.milliseconds,
        ),
      ),
    );
  }
}