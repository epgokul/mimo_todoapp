import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_bloc.dart';
import 'package:todo_app/domain/blocs/auth/auth_event.dart';
import 'package:todo_app/domain/blocs/auth/auth_state.dart';
import 'package:todo_app/presentation/screens/categories_page.dart';
import 'package:todo_app/presentation/screens/signup_page.dart';
import 'package:todo_app/presentation/widgets/custom_button.dart';
import 'package:todo_app/presentation/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          debugPrint(" state: $state");
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("SignUp success")));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesPage(),
                ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("error:${state.message}")));
          }
        },
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/mimo.png",
              height: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(controller: emailcontroller, hintText: "Email"),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: passwordcontroller,
              hintText: "Password",
            ),
            Row(children: [
              const SizedBox(
                width: 40,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ))
            ]),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "Continue",
              onTap: () {
                context.read<AuthBloc>().add(
                    SignInEvent(emailcontroller.text, passwordcontroller.text));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
