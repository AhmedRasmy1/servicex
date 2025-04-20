import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart';
import 'package:servicex/features/auth/presentation/views/register_view.dart';
import 'package:servicex/features/auth/presentation/views/verify_email_view.dart';
import 'package:servicex/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:servicex/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginCubit loginCubit;

  @override
  void initState() {
    loginCubit = getIt.get<LoginCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => loginCubit,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/User.svg",
                          height: size.height * 0.02,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "مرحبًا بك في سيرفس اكس",
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/loginimage.svg",
                        height: size.height * 0.17,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: Text(
                        "من فضلك قم بإدخال البريد الالكتروني وكلمة السر",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomTextFormFieldd(
                      hintText: "البريد الالكتروني",
                      suffixIcon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "كلمة السر",
                      suffixIcon: Icons.lock_outline,
                      obscureText: true,
                      controller: passwordController,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerifyEmailView(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xff757171),
                        ),
                        child: Text(
                          "نسيت كلمة السر؟",
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.07,
                        child: BlocListener<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginLoading) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              'جاري التسجيل...',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            } else if (state is LoginFailure) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder:
                                    (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              'البريد الإلكتروني أو كلمة السر غير صحيحة',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            } else if (state is LoginSuccess) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                              );
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginCubit.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffBDBDBD),
                            fontFamily: "Almarai",
                          ),
                          children: [
                            const TextSpan(text: "ليس لديك حساب؟ "),
                            TextSpan(
                              text: "إنشاء حساب جديد.",
                              style: const TextStyle(
                                color: ColorManager.appColor,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const RegisterView(),
                                        ),
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
