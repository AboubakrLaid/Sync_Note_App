import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  LocalDB._();
 static  final _instance = LocalDB._();

  factory LocalDB() => _instance;

  SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future clear()async{
    await _prefs?.clear();
  }

  Future<bool?> isDarkMode() async {
    await _init();
    return _prefs?.getBool('isDarkMode');
  }

  Future<void> setTheme(bool isDarkMode) async {
    await _init();
    await _prefs?.setBool('isDarkMode', isDarkMode);
  }

  Future<bool?> onBordingIsShown() async{
    await _init();
    return _prefs?.getBool("showOnBording");
  }
  Future<void> setShowOnbording() async{
    await _init();
    await _prefs?.setBool("showOnBording", true);
  }

  Future<void> setUserName(String name)async{
    await _init();
    await _prefs?.setString("UserName", name);
  }
  Future<String?> getUserName()async{
     await _init();
    return _prefs?.getString("UserName");
  }
}