import 'package:flutter/material.dart';
import '../../core/resources/constants_text_app.dart';

class LoginInstructions extends StatelessWidget {
  const LoginInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ConstantsText.instructions,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
