import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final String name;
  final String emoji;

  AddCategoryEvent(this.name, this.emoji);

  @override
  List<Object?> get props => [name, emoji];
}

class AddTaskToCategoryEvent extends CategoryEvent {
  final String categoryId;
  final String taskTitle;

  AddTaskToCategoryEvent(this.categoryId, this.taskTitle);

  @override
  List<Object?> get props => [categoryId, taskTitle];
}

class UpdateTaskEvent extends CategoryEvent {
  final String categoryId;
  final int taskIndex;
  final bool isCompleted;

  UpdateTaskEvent({
    required this.categoryId,
    required this.taskIndex,
    required this.isCompleted,
  });
}
