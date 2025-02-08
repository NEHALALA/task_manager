import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/utils/app_colors.dart';
import 'package:task_manger_app/viewmodels/prefrence_view_model.dart';
import 'package:task_manger_app/viewmodels/task_view_model.dart';
import 'package:task_manger_app/views/tasks/task_tile.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
     final isDarkMode = ref.watch(themeProvider);
    final pendingTasks = tasks.where((task) => !task.isCompleted).toList();
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Pending Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor )),
          Expanded(
            child: pendingTasks.isEmpty ? Center(child: Text("No Task Added", style: TextStyle(color: isDarkMode ? AppColors.whiteColor :AppColors.blackColor),),): ListView.builder(
              itemCount: pendingTasks.length,
              itemBuilder: (context, index) {
                final task = pendingTasks[index];
                return  TaskTile(task: task, ref: ref);
              },
            ),
          ),
          const Divider(),
           Text("Completed Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor )),
          Expanded(
            child:completedTasks.isEmpty ? Center(child: Text("No Completed Task",style: TextStyle(color: isDarkMode ? AppColors.whiteColor :AppColors.blackColor),),) : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return TaskTile(task: task, ref: ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
