import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
          // headline1: TextStyle(fontSize: 110.0.sp),
          // headline2: TextStyle(fontSize: 54.0.sp),
          // headline3: TextStyle(fontSize: 46.0.sp),
          // headline4: TextStyle(fontSize: 34.0.sp),
          // headline5: TextStyle(fontSize: 24.0.sp),
          // headline6: TextStyle(fontSize: 18.0.sp),
          // bodyText1: TextStyle(fontSize: 14.0.sp),
          // bodyText2: TextStyle(fontSize: 14.0.sp),
          // subtitle1: TextStyle(fontSize: 16.0.sp),
          // subtitle2: TextStyle(fontSize: 14.0.sp),
          // caption: TextStyle(fontSize: 10.0.sp),
          // button: TextStyle(fontSize: 12.0.sp),
          // overline: TextStyle(fontSize: 8.0.sp),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(1.0))),
      buttonTheme: ButtonThemeData(padding: EdgeInsets.all(1.0)),
      iconTheme: IconThemeData(size: 24.0.sp),
      primaryIconTheme: IconThemeData(size: 10.0.sp),
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()),
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(fontSize: 11.sp),
        unselectedLabelStyle: TextStyle(fontSize: 11.sp),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
            // headline1: TextStyle(fontSize: 112.0.sp),
            // headline2: TextStyle(fontSize: 56.0.sp),
            // headline3: TextStyle(fontSize: 47.0.sp),
            // headline4: TextStyle(fontSize: 36.0.sp),
            // headline5: TextStyle(fontSize: 26.0.sp),
            // headline6: TextStyle(fontSize: 22.0.sp),
            // bodyText1: TextStyle(fontSize: 16.0.sp),
            // bodyText2: TextStyle(fontSize: 16.0.sp),
            // subtitle1: TextStyle(fontSize: 18.0.sp),
            // subtitle2: TextStyle(fontSize: 16.0.sp),
            // caption: TextStyle(fontSize: 12.0.sp),
            // button: TextStyle(fontSize: 14.0.sp),
            // overline: TextStyle(fontSize: 10.0.sp),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(1.0))),
        buttonTheme: ButtonThemeData(padding: EdgeInsets.all(1.0)),
        // iconTheme: IconThemeData(size: 24.0.sp),
        // primaryIconTheme: IconThemeData(size: 10.0.sp),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()),
        floatingActionButtonTheme: FloatingActionButtonThemeData());
  }
}
