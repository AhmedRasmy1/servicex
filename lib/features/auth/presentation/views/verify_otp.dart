import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/common/custom_exception.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/features/auth/presentation/viewmodels/verify_otp_viewmode/verify_otp_cubit.dart';
import 'package:servicex/features/auth/presentation/views/reset_password_view.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool isButtonEnabled = false;

  String get otpCode =>
      _controllers.map((controller) => controller.text).join();
  late VerifyOtpCubit verifyOtpCubit;

  @override
  void initState() {
    verifyOtpCubit = getIt.get<VerifyOtpCubit>();
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkIfAllFilled);
    }
  }

  void _checkIfAllFilled() {
    final allFilled = _controllers.every(
      (controller) => controller.text.length == 1,
    );
    setState(() {
      isButtonEnabled = allFilled;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => verifyOtpCubit,
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
                          "التحقق من الرمز",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "التحقق من الرمز المرسل إلى بريدك الإلكتروني",
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffBDBDBD),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/verify_otp.svg",
                        height: size.height * 0.17,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: Text(
                        'ادخل رمز التحقق المرسل إليك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: size.width * 0.12,
                            child: TextFormField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (index < 5) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_focusNodes[index + 1]);
                                  } else {
                                    _focusNodes[index].unfocus();
                                  }
                                } else {
                                  if (index > 0) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_focusNodes[index - 1]);
                                  }
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    BlocListener<VerifyOtpCubit, VerifyOtpState>(
                      listener: (context, state) {
                        if (state is VerifyOtpLoading) {
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
                                          'جاري التحقق من الرمز...',
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
                        } else if (state is VerifyOtpSuccess) {
                          Navigator.pop(context); // Close loading
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResetPasswordView(),
                            ),
                          );
                        } else if (state is VerifyOtpError) {
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
                            onPressed:
                                isButtonEnabled
                                    ? () {
                                      if (_formKey.currentState!.validate()) {
                                        final code = otpCode;
                                        print("OTP Code is: $code");
                                        verifyOtpCubit.verifyOtp(
                                          otpCode: otpCode,
                                        );
                                      }
                                    }
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              disabledBackgroundColor: Colors.grey,
                            ),
                            child: Text(
                              "إدخل رمز التحقق",
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
