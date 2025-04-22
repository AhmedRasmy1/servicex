import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/resources/assets_manager.dart';
import 'package:servicex/core/resources/theme_manager.dart';

import 'login_constants.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsManager.userIcon,
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const SizedBox(width: 8),
        Text(
          LoginConstants.loginTitle,
          style: TextStyles.titleTextStyle(context),
        ),
      ],
    );
  }
}