import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servicex/core/common/custom_exception.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/auth/presentation/viewmodels/sent_otp_viewmodel/sent_otp_cubit.dart';
import 'package:servicex/features/auth/presentation/views/verify_otp.dart';
import 'package:servicex/features/auth/presentation/widgets/custom_text_field.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SentOtpCubit sentOtpCubit;
  @override
  void initState() {
    sentOtpCubit = getIt.get<SentOtpCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sentOtpCubit,
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
                          "إرسال رمز التحقق",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "الرجاء إدخال البريد الإلكتروني الخاص بك",
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/verifyemail.svg",
                        height: size.height * 0.17,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: Text(
                        "التحقق من البريد الإلكتروني",
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

                    SizedBox(height: size.height * 0.04),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.07,
                        child: BlocListener<SentOtpCubit, SentOtpState>(
                          listener: (context, state) {
                            if (state is SentOtpLoading) {
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
                                              'جاري إرسال رمز التحقق...',
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
                            }
                            // Success الحالة
                            else if (state is SentOtpSuccess) {
                              Navigator.pop(context); // Close loading
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const VerifyOtpView(),
                                ),
                              );
                            }
                            // Error الحالة
                            else if (state is SentOtpError) {
                              Navigator.pop(context); // Close loading

                              String message;
                              if (state.errorMessage is ServerError) {
                                message =
                                    (state.errorMessage as ServerError)
                                        .serverMessage ??
                                    "حدث خطأ في الخادم";
                              } else if (state.errorMessage
                                  is NoInternetError) {
                                message = "لا يوجد اتصال بالإنترنت";
                              } else if (state.errorMessage
                                  is DioHttpException) {
                                message = "فشل الاتصال بالخادم";
                              } else {
                                message = "حدث خطأ غير متوقع";
                              }

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
                                          children: [
                                            const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              message,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
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
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sentOtpCubit.sentOtp(
                                  email: emailController.text,
                                );
                                CacheService.setData(
                                  key: CacheConstants.userEmail,
                                  value: emailController.text,
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
                              "إرسال رمز التحقق",
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
