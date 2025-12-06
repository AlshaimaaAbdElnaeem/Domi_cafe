import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/login_widget.dart';
import '../widgets/sign_up_widget.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthInfo) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.info)));
          } else if (state is AuthSuccess) {
            // Update CartCubit with the logged-in user's ID
            context.read<CartCubit>().updateUserId(state.uid);

            Navigator.pushReplacementNamed(
              context,
              Routes.layout,

            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // الشاشة الرئيسية بعد إزالة الكونفليكت
          return Scaffold(
            appBar: AppBar(
              title: Text(isLogin ? "Login" : "Sign Up"),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLogin
                        ? LoginWidget(buttonText: "Login")
                        : SignUpWidget(buttonText: "Sign Up"),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: toggleMode,
                      child: Text(isLogin
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Login"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
