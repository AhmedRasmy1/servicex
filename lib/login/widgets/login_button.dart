import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicex/Home/home_page.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/resources/theme_manager.dart';
import 'package:servicex/features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart';
import 'login_constants.dart';
import 'error_dialog.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double buttonHeight;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          _handleLoginState(context, state);
        },
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.appColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            LoginConstants.loginButton,
            style: TextStyles.buttonTextStyle(context),
          ),
        ),
      ),
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) =>
                 ErrorDialog(message: LoginConstants.loadingText),
      );
    } else if (state is LoginFailure) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder:
            (context) =>
                const ErrorDialog(message: LoginConstants.errorMessage),
      );
    } else if (state is LoginSuccess) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }
}
