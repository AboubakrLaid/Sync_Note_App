import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sync_note/util/export.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  // context.theme. instead of Theme.of(context)
}

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(20, 20, 30, 1),
  scaffoldBackgroundColor: const Color(0xFF09090F),
  appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(9, 9, 15, 1)),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromRGBO(9, 9, 15, 1),
    elevation: 0,
  ),
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: Color.fromRGBO(255, 255, 255, 1.0),
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(207, 207, 219, 1),
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(255, 255, 255, 1.0),
      ),
      bodyMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(207, 207, 219, 1),
      ),
      // for the date
      displaySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(207, 207, 219, 1),
      ),

      // for the tag

      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(79, 75, 189, 1),
      ),
      labelMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      //* for the settings page
      //
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(184, 184, 190, 1),
      )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(79, 75, 189, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      alignment: Alignment.center,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xFF4F4BBD),
    foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromRGBO(230, 230, 230, 1),
    behavior: SnackBarBehavior.floating,
    contentTextStyle:
        TextStyle(fontSize: 17.0, color: Color.fromRGBO(0, 0, 0, 1)),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromRGBO(20, 20, 30, 1),
  ),
  dividerColor: const Color.fromRGBO(255, 255, 255, 1),
  iconTheme: const IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Color(0xFF4F4BBD),
 
    labelColor: Color.fromRGBO(79, 75, 189, 1),
    labelStyle: TextStyle(
       fontSize: 19,
        fontWeight: FontWeight.w600,
    ),
    unselectedLabelColor: Color.fromRGBO(207, 207, 219, 1),
  ),
  checkboxTheme: const CheckboxThemeData(
    fillColor: MaterialStatePropertyAll(Color.fromRGBO(79, 75, 189, 1)),
    visualDensity: VisualDensity.compact,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color.fromRGBO(20, 20, 30, 1),
  ),
  
);
//
//
//
//
ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFCAD4EB),
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromRGBO(202, 212, 235, 1)),
  primaryColor: const Color.fromRGBO(239, 242, 249, 1),
  
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromRGBO(202, 212, 235, 1.0),
    elevation: 0,
  ),
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: Color.fromRGBO(0, 0, 0, 1.0),
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(68, 68, 70, 1),
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 1.0),
      ),
      bodyMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(68, 68, 70, 1),
      ),
      // for the date
      displaySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(42, 42, 44, 1),
      ),
      // for the tag
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(79, 75, 189, 1),
      ),
      labelMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(75, 75, 77, 1),
      )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(79, 75, 189, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      alignment: Alignment.center,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color.fromRGBO(79, 75, 189, 1),
    foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromRGBO(30, 30, 30, 1.0),
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(fontSize: 17.0),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromRGBO(239, 242, 249, 1),
  ),
  dividerColor: const Color.fromRGBO(0, 0, 0, 1),
  iconTheme: const IconThemeData(color: Color.fromRGBO(0, 0, 0, 1)),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Color(0xFF4F4BBD),
    labelColor: Color(0xFF4F4BBD),
    labelStyle: TextStyle(
       fontSize: 19,
        fontWeight: FontWeight.w600,
    ),
    unselectedLabelColor: Color.fromRGBO(68, 68, 70, 1),
  ),
  checkboxTheme: const CheckboxThemeData(
    fillColor: MaterialStatePropertyAll(Color.fromRGBO(79, 75, 189, 1)),
    visualDensity: VisualDensity.compact,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color.fromRGBO(239, 242, 249, 1),
  ),
  
);
