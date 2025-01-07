import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/blocs/category/category_bloc.dart';
import 'package:todo_app/domain/blocs/category/category_event.dart';
import 'package:todo_app/domain/blocs/category/category_state.dart';
import 'package:todo_app/presentation/widgets/custom_text_field.dart';

class TaskPage extends StatelessWidget {
  final Map<String, dynamic> category;
  const TaskPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateTaskDialog(context);
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    category['name'] ?? "Unknown category",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.search_rounded,
                    size: 40,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoriesLoadedState) {
                  return TasksLoaded(
                    categoryId: category['id'],
                  );
                } else if (state is CategoriesErrorState) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Unexpected state",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void showCreateTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CustomTextField(
              controller: taskController, hintText: "Type your task"),
          actions: [
            TextButton(
                onPressed: () {
                  debugPrint("id:${category['id']}");
                  context.read<CategoryBloc>().add(AddTaskToCategoryEvent(
                      category['id'], taskController.text));
                },
                child: const Text("Add task"))
          ],
        );
      },
    );
  }
}

class TasksLoaded extends StatelessWidget {
  final String categoryId;
  const TasksLoaded({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          // Find the specific category from the state
          if (state is CategoriesLoadedState) {
            final category = state.categories.firstWhere(
              (cat) => cat['id'] == categoryId,
              orElse: () => {},
            );

            if (category == null) {
              return const Center(
                child: Text(
                  'Category not found',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            final tasks = category['tasks'] as List<dynamic>?;

            if (tasks == null || tasks.isEmpty) {
              return const Center(
                child: Text(
                  'No tasks yet',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index] as Map<String, dynamic>;
                return ListTile(
                  leading: Radio<bool>(
                    value: true, // Set the value for this option (true)
                    groupValue: task['isCompleted'] ??
                        false, // Bind to task's isCompleted field
                    onChanged: (value) {
                      // Debug prints to check the values
                      debugPrint(categoryId);
                      debugPrint("$index");
                      debugPrint("$value");

                      // Dispatch the event to update task completion status
                      context.read<CategoryBloc>().add(
                            UpdateTaskEvent(
                              categoryId: categoryId,
                              taskIndex: index,
                              isCompleted: value ??
                                  false, // Pass the new value (true or false)
                            ),
                          );
                    },
                  ),
                  title: Text(
                    task['title'] ?? '',
                    style: TextStyle(
                      decoration: task['isCompleted'] == true
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                );
              },
            );
          }

          if (state is CategoriesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoriesErrorState) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(
            child: Text(
              'Unexpected state',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
