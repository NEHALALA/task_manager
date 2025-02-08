
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/core/database/database_helper.dart';
import '../models/task_model.dart';


class TaskViewModel extends StateNotifier<List<TaskModel>> {
  final DatabaseHelper dbHelper;

  TaskViewModel(this.dbHelper) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await dbHelper.getTasks();
    state = tasks;
  }

  Future<void> addTask(String title, String description) async {
    final task = TaskModel(title: title, description: description);
    await dbHelper.insertTask(task);
    loadTasks(); // Refresh the state
  }

  Future<void> toggleTaskStatus(int id, bool isCompleted) async {
    await dbHelper.toggleTaskStatus(id, isCompleted);
    loadTasks(); // Refresh state after DB update
  }

  Future<void> deleteTask(int id) async {
    await dbHelper.deleteTask(id);
    loadTasks();
  }
}

// Provide the ViewModel
final taskProvider = StateNotifierProvider<TaskViewModel, List<TaskModel>>(
  (ref) => TaskViewModel(DatabaseHelper()),
);



