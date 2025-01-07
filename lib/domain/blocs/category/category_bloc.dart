import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domain/blocs/category/category_event.dart';
import 'package:todo_app/domain/blocs/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  CategoryBloc() : super(CategoriesLoadingState()) {
    on<LoadCategoriesEvent>(_loadCategories);
    on<AddCategoryEvent>(_addCategory);
    on<AddTaskToCategoryEvent>(_addTaskToCategory);
    on<UpdateTaskEvent>(_onUpdateTaskStatus);
  }

  Future<void> _loadCategories(
      LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoriesLoadingState());
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(CategoriesErrorState("User not authenticated."));
        return;
      }

      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .get();

      final categories =
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();

      emit(CategoriesLoadedState(categories));
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }

  Future<void> _addCategory(
      AddCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(CategoriesErrorState("User not authenticated."));
        return;
      }

      await firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .add({
        'name': event.name,
        'emoji': event.emoji,
        'tasks': [], // Initialize with an empty task list
      });

      add(LoadCategoriesEvent()); // Refresh the category list
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }

  Future<void> _addTaskToCategory(
      AddTaskToCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(CategoriesErrorState("User not authenticated."));
        return;
      }

      // Get reference to the specific category
      final categoryRef = firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(event.categoryId);

      // Get current category data
      final categoryDoc = await categoryRef.get();
      if (!categoryDoc.exists) {
        throw Exception('Category not found');
      }

      // Get current tasks and add new task
      final currentTasks =
          List<Map<String, dynamic>>.from(categoryDoc.data()?['tasks'] ?? []);
      currentTasks.add({
        'title': event.taskTitle,
        'isCompleted': false,
      });

      // Update the category with new tasks array
      await categoryRef.update({
        'tasks': currentTasks,
      });

      // Emit the updated categories state to reflect changes
      final updatedCategory = categoryDoc.data();
      final updatedCategories =
          List<Map<String, dynamic>>.from(updatedCategory?['tasks'] ?? []);
      emit(CategoriesLoadedState(updatedCategories));

      // Optionally, refresh the categories to trigger the UI update
      // add(LoadCategoriesEvent()); // Uncomment if needed to reload all categories
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateTaskStatus(
      UpdateTaskEvent event, Emitter<CategoryState> emit) async {
    try {
      final userId = auth.currentUser?.uid;
      debugPrint("Moonjya id:${event.categoryId}");
      final categoryRef = firestore
          .collection('users') // Collection that contains all users
          .doc(userId) // The current user
          .collection(
              'categories') // Categories collection inside the user's document
          .doc(event.categoryId);
      final doc = await categoryRef.get();

      if (!doc.exists) {
        debugPrint("moonji ");
      } else {
        debugPrint("moonjila");
      }

      final data = doc.data()!;
      debugPrint("$data");
      final tasks = List.from(data['tasks'] ?? []);

      // Update the specific task's completion status
      if (tasks.length > event.taskIndex) {
        tasks[event.taskIndex] = {
          ...tasks[event.taskIndex],
          'isCompleted': event.isCompleted,
        };

        // Update in Firebase
        await categoryRef.update({'tasks': tasks});

        // Reload categories to refresh the UI
        add(LoadCategoriesEvent());
      }
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }
}
