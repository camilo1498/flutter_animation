import 'package:animations/pages/mini_player/mini_player_page.dart';
import 'package:animations/routes/app_pages.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async{

/*
  ErrorWidget.builder = (FlutterErrorDetails details) {

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(child: Text(details.exception.toString(), style: TextStyle(color: Colors.white),)),
    );
  };
*/

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
          getPages: AppPages.appPages,
          initialRoute: AppRoutes.mainPage,
          //home: const MiniPlayerPage(),
          supportedLocales: const [Locale('en', 'US')],
          defaultTransition: Transition.fade,
          transitionDuration: 300.milliseconds,
        ),
      ),
    );
  }
}