import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class LoginWidget extends StatefulWidget {
  final String buttonText;
  const LoginWidget({super.key, this.buttonText = "Login"});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
            const SizedBox(height: 16),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.signInWithEmail(
                        emailController.text.trim(),
                        passwordController.text.trim());
                  }
                },
                child: Text(widget.buttonText,
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),

            // Google Sign-In
            TextButton.icon(
              onPressed: () => cubit.signInWithGoogle(),
              icon: const Icon(Icons.login),
              label: const Text("Sign in with Google"),
            ),

            const SizedBox(height: 16),

            // Reset Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                      .hasMatch(email)) {
                    cubit.resetPassword(email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Enter a valid email to reset password")),
                    );
                  }
                },
                child: const Text("Forgot Password?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
