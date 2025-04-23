import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/User_type/view/choose_user_type_view.dart';
import '../../core/resources/constants_text_app.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: ColorManager.textColor,
          ),
          children: [
            const TextSpan(text: ConstantsText.noAccount),
            TextSpan(
              text: ConstantsText.createAccount,
              style: const TextStyle(color: ColorManager.appColor),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseUserTypeView(),
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
