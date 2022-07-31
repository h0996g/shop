import 'package:agence/diohelper/dio_helper.dart';
import 'package:agence/home/home.dart';
import 'package:agence/login/cupitlogin/cupitl.dart';
import 'package:agence/login/cupitlogin/cupitmain.dart';
import 'package:agence/login/cupitlogin/observer.dart';
import 'package:agence/login/login.dart';
import 'package:agence/login/onbording.dart';
import 'package:agence/login/other/cachhelper.dart';
import 'package:agence/shared/components/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

import 'home/cubitHome/cupit_home.dart';
import 'home/cubitHome/homeStates.dart';

main() {
  BlocOverrides.runZoned(
    () async {
      // Use cubits...
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CachHelper.init();
      bool onbordingmain = CachHelper.getData(key: 'onbording') ?? false;
      // onbordingmain ??= false;
      bool darkswitchmain = CachHelper.getData(key: 'dartswitch') ?? false;

      TOKEN = CachHelper.getData(key: 'token') ?? '';
      Widget widgetmain;
      if (onbordingmain != false) {
        if (TOKEN != '') {
          widgetmain = const Home();
        } else {
          widgetmain = LoginScreen();
        }
      } else {
        widgetmain = const Onbording();
      }

      // print(onbordingmain);
      runApp(MyApp(darkswitchmain, widgetmain));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool darkswitchmain;
  Widget widgetmain;

  MyApp(this.darkswitchmain, this.widgetmain);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CupitHome()
              ..getHomeData()
              ..getCategories()
              ..changeSwitch(darkswitchmain: darkswitchmain)
              ..getFAvorite()),
        BlocProvider(create: (context) => CupitMain()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: BlocConsumer<CupitHome, ShopeHomeStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widgetmain,
            themeMode: CupitHome.get(context).dartSwitch
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed),
              textTheme: const TextTheme(
                  headline4: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  bodyText2: TextStyle(
                    color: Colors.black,
                  ),
                  headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18)),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                elevation: 10,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('#121212'),
                  unselectedItemColor: Colors.white),
              textTheme: const TextTheme(
                  headline4: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  bodyText2: TextStyle(
                    color: Colors.white,
                  ),
                  headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18)),
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#121212'),
                    statusBarIconBrightness: Brightness.light),
                elevation: 10,
                backgroundColor: HexColor('#121212'),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
