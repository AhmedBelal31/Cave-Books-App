import 'package:bloc/bloc.dart';
import 'package:cave_books_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Network/local/Chache_Helper.dart';
import 'Network/remote/Dio_Helper.dart';
import 'Network/remote/bloc_observer.dart';
import 'Network/remote/reading_dio_helper.dart';
import 'const.dart';
import 'modules/home/Home_Layout.dart';
import 'modules/home/Search/BookDetailsPage.dart';
import 'modules/home/Search/BooksList.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/onboarding_Screen.dart';
import 'modules/shop_register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache_Helper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelper2.init();

  bool? onBoarding = Cache_Helper.getDataFromSharedPref(key: 'onboarding');
  // print(onBoarding);
  token = Cache_Helper.getDataFromSharedPref(key: 'token');
  print(token);
  Widget? widget;

  if (onBoarding == null) {
    widget = OnBoardingScreen();
  } else {
    if (token != null)
      widget = Home_Layout();
    else
      widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
  // runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final Widget startWidget;

  const MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Janna',
        primarySwatch: defaultColor,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: defaultColor),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            )),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: startWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
