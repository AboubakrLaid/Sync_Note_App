import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sync_note/routes/routes.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/screens/user_name/user_view_model.dart';
import 'package:sync_note/util/global_variable.dart';

import 'screens/home/home.dart';
import 'util/export.dart';
import 'util/refresh.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await crudStorage.open();
  bool? x = await localDB.isDarkMode();
  appTheme.initThemeMode = (x == true
      ? ThemeMode.dark
      : (x == false ? ThemeMode.light : ThemeMode.system));

  //
  //
  bool? onBordindIsShown = await localDB.onBordingIsShown();
  if (onBordindIsShown != null && onBordindIsShown) {
    userName = (await localDB.getUserName()) ?? "default";
    defaultScreen = const Home();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    appTheme.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    appTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserNameViewModel()),
          ChangeNotifierProvider(create: (context) => AddNoteViewModel()),
          ChangeNotifierProvider(create: (context) => Refresh()),
        ],
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: appTheme.lightTheme,
          darkTheme: appTheme.darkTheme,
          themeMode: appTheme.themeMode,
          themeAnimationCurve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
    );
  }
}
