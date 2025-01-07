import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_event.dart';
import 'package:todo_app/domain/blocs/auth/auth_state.dart';
import 'package:todo_app/domain/blocs/category/category_bloc.dart';
import 'package:todo_app/domain/blocs/category/category_event.dart';
import 'package:todo_app/presentation/screens/categories_page.dart';
import 'package:todo_app/presentation/screens/login_page.dart';
import 'package:todo_app/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc()..add(LoadCategoriesEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TodoTheme.lightTheme,
        darkTheme: TodoTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        debugPrint("State: $state");
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          return CategoriesPage();
        } else if (state is UnAuthenticated) {
          return LoginPage();
        } else {
          // Handle unexpected state
          return const Center(child: Text('Unexpected error occurred'));
        }
      },
    );
  }
}
