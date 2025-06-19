import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/home_screen.dart';
import 'package:payme/auth/application/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can access the authControllerProvider here if needed
    final authController = ref.watch(authControllerProvider);
    final formKey = GlobalKey<FormState>();

    authController.when(
      initial: () {},
      loading: () {},
      authenticated: () {
        // Navigate to HomeScreen if authenticated
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      unauthenticated: () {},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          primary: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const Text('Login Screen'),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Login'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуюста, введите адрес электронной почты';
                  }else if (value.length < 4) {
                    return 'Пожалуйста, введите не менее 4 символов';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  } else if (value.length < 3) {
                    return 'Пожалуйста, введите не менее 6 символов';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Full width button
                ),
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    // If the form is valid, proceed with login
                    ref.read(authControllerProvider.notifier).login(
                      emailController.text,
                      passwordController.text,
                    );
                  }

                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
