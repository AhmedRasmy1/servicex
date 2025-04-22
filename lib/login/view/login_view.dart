import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicex/login/widgets/login_button.dart';
import 'package:servicex/login/widgets/login_footer.dart';
import 'package:servicex/login/widgets/login_form.dart';
import 'package:servicex/login/widgets/login_header.dart';
import 'package:servicex/login/widgets/login_image.dart';
import 'package:servicex/login/widgets/login_instructions.dart';
import 'package:servicex/login/widgets/login_welcome.dart';
import '../../core/di/di.dart';
import '../../features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    _loginCubit = getIt.get<LoginCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _loginCubit.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _loginCubit,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginHeader(),
                  SizedBox(height: 8),
                  LoginWelcomeMessage(),
                  SizedBox(height: size.height * 0.08),
                  LoginImage(),
                  SizedBox(height: size.height * 0.05),
                  LoginInstructions(),
                  SizedBox(height: size.height * 0.03),
                  LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    formKey: _formKey,
                    onLoginPressed: _handleLogin,
                  ),
                  SizedBox(height: size.height * 0.04),
                  LoginButton(
                    onPressed: _handleLogin,
                    buttonHeight: size.height * 0.07,
                  ),
                  SizedBox(height: size.height * 0.05),
                  LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
