import 'package:flutter/material.dart';
import'package:servicex/features/auth/presentation/widgets/custom_text_field.dart';
import'package:servicex/login/widgets/login_constants.dart';
class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onLoginPressed;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextFormFieldd(
      hintText: LoginConstants.emailHint,
      suffixIcon: Icons.email_outlined,
      controller: emailController,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormFieldd(
      hintText: LoginConstants.passwordHint,
      suffixIcon: Icons.lock_outline,
      obscureText: true,
      controller: passwordController,
    );
  }
}