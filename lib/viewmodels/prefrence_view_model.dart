import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/repositories/prefrence_repository.dart';


final themeProvider = StateNotifierProvider<PreferencesViewModel, bool>((ref) {
  return PreferencesViewModel();
});

class PreferencesViewModel extends StateNotifier<bool> {
  final PreferencesRepository _preferencesRepo = PreferencesRepository();

  PreferencesViewModel() : super(false) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    state = await _preferencesRepo.getTheme();
  }

  Future<void> toggleTheme() async {
    state = !state;
    await _preferencesRepo.setTheme(state);
  }
}
