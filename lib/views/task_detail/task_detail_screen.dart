
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manger_app/models/task_model.dart';
import 'package:task_manger_app/utils/app_colors.dart';
import 'package:task_manger_app/viewmodels/prefrence_view_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
   final WidgetRef ref;

  const TaskDetailScreen({super.key, required this.task, required this.ref});

  @override
  Widget build(BuildContext context) {
     final isDarkMode = ref.watch(themeProvider);
     print("isDarkMode in detail: ${isDarkMode}");
    
    return Scaffold(
      backgroundColor:  isDarkMode?  AppColors.blackColor : AppColors.whiteColor ,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);},color:   isDarkMode?  AppColors.whiteColor : AppColors.blackColor ,),
         backgroundColor:  isDarkMode?  AppColors.blackColor : AppColors.whiteColor ,
         centerTitle: true,
         scrolledUnderElevation: 0,
        title: Text(task.title,style: TextStyle(color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor ),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${task.title}",
                style:
                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor )),
            const SizedBox(height: 10),
            Text("Description: ${task.description}",
                style:  TextStyle(fontSize: 16,color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor )),
            const SizedBox(height: 20),
            Row(
              children: [
                Text("Status: ",
                    style:  TextStyle(fontSize: 16,color:  isDarkMode?  AppColors.whiteColor : AppColors.blackColor )),
                    Text("${task.isCompleted ? "Completed" : "Pending"}",style:  TextStyle(fontSize: 16, color: task.isCompleted ? Colors.green : Colors.red))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
