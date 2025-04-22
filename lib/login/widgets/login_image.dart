import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/resources/assets_manager.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AssetsManager.loginImage,
        height: MediaQuery.of(context).size.height * 0.17,
      ),
    );
  }
}