import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  const HomeService({required this.prefs});
  final SharedPreferences prefs;

  Future<void> save(String type, bool cache) async {
    await prefs.setBool(type, cache);
  }

  bool? getBool(String type) => prefs.getBool(type);
}
