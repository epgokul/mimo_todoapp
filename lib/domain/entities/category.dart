class Category {
  final String id; // Unique identifier for the category
  final String name; // Name of the category
  final String emoji; // Emoji representing the category
  final List<Task> tasks; // List of tasks under this category

  Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.tasks,
  });

  // Factory method to create a Category from Firebase data
  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      emoji: map['emoji'] ?? '',
      tasks: (map['tasks'] as List<dynamic>)
          .map((task) => Task.fromMap(task as Map<String, dynamic>, task['id']))
          .toList(),
    );
  }

  // Convert Category to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emoji': emoji,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }
}

class Task {
  final String title; // Task title
  final bool isCompleted; // Task status (completed or not)

  Task({
    required this.title,
    this.isCompleted = false,
  });

  // Factory method to create a Task from Firebase data
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // Convert Task to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
