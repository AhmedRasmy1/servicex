import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/common/custom_exception.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodels/reset_password_viewmodel/reset_password_cubit.dart';
import 'login_view.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ResetPasswordCubit resetPasswordCubit;
  @override
  void initState() {
    resetPasswordCubit = getIt.get<ResetPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => resetPasswordCubit,
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.arrow_back_ios, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          "إعادة تعيين كلمة المرور",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "احصل على كلمة مرور جديدة",
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/cahnge_password_image.svg",
                        height: size.height * 0.17,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: Text(
                        "من فضلك قم بكتابة كلمة المرور الجديدة",
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
                      hintText: 'كلمة المرور',
                      suffixIcon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                    ),

                    CustomTextFormFieldd(
                      hintText: 'تأكيد كلمة المرور',
                      suffixIcon: Icons.lock_outline,
                      controller: confirmPasswordController,
                      obscureText: true,
                      isConfirmPasswordField: true,
                      originalPasswordController: passwordController,
                    ),

                    SizedBox(height: size.height * 0.04),
                    BlocListener<ResetPasswordCubit, ResetPasswordState>(
                      listener: (context, state) {
                        if (state is ResetPasswordLoading) {
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
                                          'جاري إعادة تعيين كلمة السر...',
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
                        } else if (state is ResetPasswordSuccess) {
                          Navigator.pop(context); // Close loading
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
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/successicon.svg',
                                          height: 100,
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'لقد تم تغيير كلمة مرور حسابك بنجاح، يمكنك الآن العودة وتسجيل الدخول من جديد',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          const LoginPage(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorManager.appColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'تسجيل الدخول',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        } else if (state is ResetPasswordError) {
                          Navigator.pop(context); // Close loading

                          String message;
                          if (state.exception is ServerError) {
                            message =
                                (state.exception as ServerError)
                                    .serverMessage ??
                                "حدث خطأ في الخادم";
                          } else if (state.exception is NoInternetError) {
                            message = "لا يوجد اتصال بالإنترنت";
                          } else if (state.exception is DioHttpException) {
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
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: size.height * 0.07,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                resetPasswordCubit.resetPassword(
                                  email: CacheService.getData(
                                    key: CacheConstants.userEmail,
                                  ),
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
                              "إعادة تعيين كلمة المرور",
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
