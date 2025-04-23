import 'package:flutter/material.dart';
import 'package:servicex/core/resources/theme_manager.dart';
import '../../core/resources/constants_text_app.dart';

class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ConstantsText.welcomeMessage,
      style: TextStyles.subtitleTextStyle(context),
    );
  }
}
