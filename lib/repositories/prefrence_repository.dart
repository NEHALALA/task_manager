import 'package:hive/hive.dart';

class PreferencesRepository {
  static const String _boxName = "preferences";

  Future<void> setTheme(bool isDark) async {
    final box = await Hive.openBox(_boxName);
    await box.put('isDark', isDark);
  }

  Future<bool> getTheme() async {
    final box = await Hive.openBox(_boxName);
    return box.get('isDark', defaultValue: false);
  }
}
