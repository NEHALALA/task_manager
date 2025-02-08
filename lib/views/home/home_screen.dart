import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/services/notification_service.dart';
import 'package:task_manger_app/utils/app_colors.dart';
import 'package:task_manger_app/viewmodels/prefrence_view_model.dart';
import 'package:task_manger_app/viewmodels/task_view_model.dart';
import 'package:task_manger_app/views/tasks/task_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key}); // Add 'const' for better performance

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: isDarkMode?  AppColors.blackColor : AppColors.whiteColor,
      appBar: AppBar(
       backgroundColor: isDarkMode? AppColors.blackColor : AppColors.whiteColor,
          centerTitle: true,
          scrolledUnderElevation: 0,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => RotationTransition(
                    turns: animation,
                    child: child,
                  ),
                  child: isDarkMode
                      ? const Icon(Icons.nightlight_round,
                          key: ValueKey('moon'), color: AppColors.yellowColor)
                      : const Icon(Icons.wb_sunny,
                          key: ValueKey('sun'), color: AppColors.orangeColor),
                ),
              ),
            ),
          ],
          title:  Text(
            "Task Manager",
            style: TextStyle(fontWeight: FontWeight.bold,color : isDarkMode?  AppColors.whiteColor : AppColors.blackColor ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return const Row(
                children: [
                  TaskList(),
                ],
              );
            } else {
              return const TaskList();
            }
          },
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final isDarkMode = ref.watch(themeProvider);
  final theme = Theme.of(context);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          "Add Task",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle:
                    TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDarkMode ? Colors.white70 : Colors.black54),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle:
                    TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDarkMode ? Colors.white70 : Colors.black54),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purpleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                ref.read(taskProvider.notifier).addTask(
                    titleController.text, descriptionController.text);
                      NotificationService.showNotification(
        "New Task Added", "Your task has been successfully added!");
                Navigator.pop(context);
              }
            },
            child:  Text("Add",style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}

}


