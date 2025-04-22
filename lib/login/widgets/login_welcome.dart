import 'package:flutter/material.dart';
import 'package:servicex/core/resources/theme_manager.dart';
import 'login_constants.dart';

class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LoginConstants.welcomeMessage,
      style: TextStyles.subtitleTextStyle(context),
    );
  }
}