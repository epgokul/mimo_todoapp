import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesLoadingState extends CategoryState {}

class CategoriesLoadedState extends CategoryState {
  final List<Map<String, dynamic>> categories;

  CategoriesLoadedState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesErrorState extends CategoryState {
  final String error;

  CategoriesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
