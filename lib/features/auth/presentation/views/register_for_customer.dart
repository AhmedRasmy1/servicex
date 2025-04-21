import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import '../../../../core/common/custom_exception.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodels/register_viewmodel/register_cubit.dart';
import 'login_view.dart';
import '../widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class RegisterForCustomerView extends StatefulWidget {
  const RegisterForCustomerView({super.key});

  @override
  State<RegisterForCustomerView> createState() =>
      _RegisterForCustomerViewState();
}

class _RegisterForCustomerViewState extends State<RegisterForCustomerView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RegisterCubit registerCubit;
  File? _selectedImage;

  @override
  void initState() {
    registerCubit = getIt.get<RegisterCubit>();
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => registerCubit,
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
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "يمكنك الان إنشاء حساب جديد",
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: size.width * 0.16,
                            backgroundImage:
                                _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : null,
                            child:
                                _selectedImage == null
                                    ? Image.asset(
                                      'assets/images/defaultimageuser.png',
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorManager.appColor,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomTextFormFieldd(
                      hintText: "الإسم الأول",
                      suffixIcon: Icons.person_outline,
                      controller: firstNameController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "الإسم الأخير",
                      suffixIcon: Icons.person_outline,
                      controller: lastNameController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "رقم الهاتف",
                      suffixIcon: Icons.phone_android_outlined,
                      controller: phoneController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "البريد الالكتروني",
                      suffixIcon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "كلمة السر",
                      suffixIcon: Icons.lock,
                      obscureText: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: 'تأكيد كلمة المرور',
                      suffixIcon: Icons.lock_outline,
                      controller: confirmPasswordController,
                      obscureText: true,
                      isConfirmPasswordField: true,
                      originalPasswordController: passwordController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormFieldd(
                      hintText: "العنوان",
                      suffixIcon: Icons.location_on_outlined,
                      controller: addressController,
                    ),

                    SizedBox(height: size.height * 0.04),
                    BlocListener<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterLoading) {
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
                                          "جاري إنشاء الحساب...",
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
                        } else if (state is RegisterSuccess) {
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
                                          'assets/images/congratulationsIcon.svg',
                                          height: 100,
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          "تهانينا! \nتم إنشاء حسابك بنجاح",
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
                        } else if (state is RegisterError) {
                          Navigator.pop(context); // Close loading

                          String message;
                          if (state.errorMessage is ServerError) {
                            message =
                                (state.errorMessage as ServerError)
                                    .serverMessage ??
                                "حدث خطأ في الخادم";
                          } else if (state.errorMessage is NoInternetError) {
                            message = "لا يوجد اتصال بالإنترنت";
                          } else if (state.errorMessage is DioHttpException) {
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedImage == null) {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
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
                                                  'يجب إضافة صورة شخصية للمستخدم',
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
                                  return;
                                }
                                File file = File(_selectedImage!.path);
                                String fileNameWithExtension = basename(
                                  file.path,
                                );
                                FormData formData = FormData.fromMap({
                                  'FirstName': firstNameController.text,
                                  'LastName': lastNameController.text,
                                  'email': emailController.text,
                                  'phone': phoneController.text,
                                  'password': passwordController.text,
                                  'address': addressController.text,
                                  'cover': await MultipartFile.fromFile(
                                    _selectedImage!.path,
                                    filename: fileNameWithExtension,
                                  ),
                                  'role': CacheService.getData(
                                    key: CacheConstants.userType,
                                  ),
                                });

                                registerCubit.register(formData: formData);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "إنشاء حساب جديد",
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
                            const TextSpan(text: "لديك حساب بالفعل؟ "),
                            TextSpan(
                              text: "تسجيل الدخول.",
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
                                              (context) => const LoginPage(),
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
