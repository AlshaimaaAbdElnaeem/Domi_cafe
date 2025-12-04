import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class SignUpWidget extends StatefulWidget {
  final String buttonText;
  const SignUpWidget({super.key, this.buttonText = "Sign Up"});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Name is required";
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Email is required";
                if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                    .hasMatch(value.trim())) return "Enter a valid email";
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Password is required";
                if (value.trim().length < 6)
                  return "Password must be at least 6 chars";
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.signUpWithEmail(emailController.text.trim(),
                        passwordController.text.trim(), nameController.text.trim());
                  }
                },
                child: Text(widget.buttonText,
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),

            // Google Sign-Up
            TextButton.icon(
              onPressed: () => cubit.signInWithGoogle(),
              icon: const Icon(Icons.login),
              label: const Text("Sign Up with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
