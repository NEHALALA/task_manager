class TaskModel {
  final int? id; // Add ID for database operations
  final String title;
  final String description;
  bool isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Convert TaskModel to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0, // Store as 0 or 1 in DB
    };
  }

  // Create TaskModel from a database map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
