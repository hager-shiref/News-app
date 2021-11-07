// ignore_for_file: use_key_in_widget_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/cubit/bloc_observer.dart';

void main() async {
  // بيتأكد ان كل حاجه ف الميثود خلصت الاول وبعدين بيفتح الأبليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  bool ? isDark=CachHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark ?? false,));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({required this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(create: (context)=>NewsCubit()
          ..getBusiness()
          ..getSports()
          ..getSciences()),

      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, NewsStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system
           /* NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light*/,
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.black45,
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black45,
                      statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.black45,
                  iconTheme: IconThemeData(color: Colors.white),
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20.0,
                    backgroundColor: Colors.black45,
                    unselectedItemColor: Colors.grey),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20.0),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
