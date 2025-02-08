import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/models/task_model.dart';
import 'package:task_manger_app/utils/app_colors.dart';
import 'package:task_manger_app/viewmodels/prefrence_view_model.dart';
import 'package:task_manger_app/viewmodels/task_view_model.dart';
import 'package:task_manger_app/views/task_detail/task_detail_screen.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final WidgetRef ref;

  const TaskTile({super.key, required this.task, required this.ref});

  @override
  Widget build(BuildContext context) {
     final isDarkMode = ref.watch(themeProvider);
    return  ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor 
        ),
      ),
      subtitle: Text(task.isCompleted ? "Completed" : "Pending",style: TextStyle(color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor ),),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          if (task.id != null) {
            ref.read(taskProvider.notifier).toggleTaskStatus(task.id!, value!);
          }
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskDetailScreen(task: task,ref: ref,),
          ),
        );
      },
      onLongPress: () {
        if (task.id != null) {
          ref.read(taskProvider.notifier).deleteTask(task.id!);
        }
      },
    );
  }
}
