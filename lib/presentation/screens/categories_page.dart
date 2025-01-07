import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/blocs/category/category_bloc.dart';
import 'package:todo_app/domain/blocs/category/category_event.dart';
import 'package:todo_app/domain/blocs/category/category_state.dart';
import 'package:todo_app/presentation/screens/settings_page.dart';
import 'package:todo_app/presentation/widgets/categories_loaded_view.dart';
import 'package:todo_app/presentation/widgets/custom_text_field.dart';
import 'package:todo_app/presentation/widgets/quote_widget.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(
                              user: user,
                            ),
                          ));
                    },
                    child: const CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.search_rounded,
                    size: 40,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const QuoteWidget(),
            const SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoriesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CategoriesLoadedState) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text("No categories found. Add one!"),
                      );
                    }
                    return CategoriesLoadedView(
                      categories: state.categories,
                      addCategory: showCreateCategoryDialog,
                    );
                  } else if (state is CategoriesErrorState) {
                    return Center(
                      child: Text("Error: ${state.error}"),
                    );
                  } else {
                    return const Center(
                      child: Text("Unexpected state. Please try again."),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCreateCategoryDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emojiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                hintText: "Category Name",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                  controller: emojiController, hintText: "Add Emoji"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final emoji = emojiController.text;

                if (name.isNotEmpty && emoji.isNotEmpty) {
                  context.read<CategoryBloc>().add(
                        AddCategoryEvent(name, emoji),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
