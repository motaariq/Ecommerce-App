import 'dart:io';
import 'package:ecommerce/components/conistants.dart';
import 'package:ecommerce/layout/homeLayout.dart';
import 'package:ecommerce/screens/home_screen/homeScreen.dart';
import 'package:ecommerce/screens/login_screen/loginScreen.dart';
import 'package:ecommerce/screens/onBoarding_screen/onBoarding_screen.dart';
import 'package:ecommerce/shared/Cache/cacheHelper.dart';
import 'package:ecommerce/shared/Dio/dioHelper.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await cacheHelper.init();
  await dioHelper.init();
  Widget widget;
  bool? onBoarding = cacheHelper.getData(key: 'onBoarding');
  token = cacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = homeLayout();
    } else {
      widget = loginScreen();
    }
  } else {
    widget = onBoardingScreen();
  }

  print(onBoarding);
  runApp(MyApp(startScreen: widget));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({
    required this.startScreen,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=> ShopCubit()..getHome()..getCategory()..getFavorites()
          )
      ],
     child: MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'jannah',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            backgroundColor: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark)),
      ),
      debugShowCheckedModeBanner: false,
      home: startScreen,
    ) 
     );
    
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
