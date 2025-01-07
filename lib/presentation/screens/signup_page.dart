import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_event.dart';
import 'package:todo_app/domain/blocs/auth/auth_state.dart';
import 'package:todo_app/presentation/screens/categories_page.dart';
import 'package:todo_app/presentation/screens/login_page.dart';
import 'package:todo_app/presentation/widgets/custom_button.dart';
import 'package:todo_app/presentation/widgets/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Sign up success")));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesPage(),
                ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error:${state.message}")));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create an account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: namecontroller, hintText: "Full name"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(controller: emailcontroller, hintText: "email"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: passwordcontroller, hintText: "password"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: confirmpasswordcontroller,
                  hintText: "confirm password"),
              const SizedBox(height: 20),
              CustomButton(
                text: "Continue",
                onTap: () {
                  context.read<AuthBloc>().add(SignUpEvent(emailcontroller.text,
                      passwordcontroller.text, namecontroller.text));
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
