import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodel/order/order_cubit.dart';

class CreateOrderView extends StatefulWidget {
  const CreateOrderView({super.key});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  late OrderCubit orderCubit;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _image;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    orderCubit = getIt.get<OrderCubit>();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: this.context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => orderCubit,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'طلب خدمة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
          backgroundColor: const Color(0xFFF7FAFC),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTextField(
                    _descriptionController,
                    'اكتب وصف المشكلة',
                    FontAwesomeIcons.noteSticky,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    _addressController,
                    'ادخل العنوان',
                    FontAwesomeIcons.locationDot,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle('التاريخ والوقت'),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(child: _buildDatePicker()),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTimePicker()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle('صورة المشكلة'),
                  const SizedBox(height: 30),
                  _buildImagePicker(),
                  const SizedBox(height: 30),
                  BlocListener<OrderCubit, OrderState>(
                    listener: (context, state) async {
                      if (state is OrderLoading) {
                        setState(() => _isSubmitting = true);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        );
                      } else {
                        setState(() => _isSubmitting = false);
                        Navigator.pop(context); // Close loading dialog
                        if (state is OrderSuccess) {
                          await showDialog(
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
                                        // Replace with your SVG widget import if not already imported
                                        // import 'package:flutter_svg/flutter_svg.dart';
                                        SvgPicture.asset(
                                          'assets/images/successicon.svg',
                                          height: 100,
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          "تهانينا! \nتم إرسال الطلب بنجاح",
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
                                              Navigator.pop(
                                                context,
                                              ); // Close dialog
                                              Navigator.pop(
                                                context,
                                              ); // Go back to previous screen
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
                                              'العودة',
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
                        } else if (state is OrderFailed) {
                          await showDialog(
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
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 80,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          state.message,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
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
                                              Navigator.pop(
                                                context,
                                              ); // Close dialog
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
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
                                              'حسناً',
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
                        }
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() => _isSubmitting = true);
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() => _isSubmitting = false);
                          File file = File(_image!.path);
                          String fileNameWithExtension = basename(file.path);
                          FormData formData = FormData.fromMap({
                            'ProblemDescription': _descriptionController.text,
                            'date':
                                _selectedDate != null
                                    ? DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(_selectedDate!)
                                    : '',
                            'time':
                                _selectedTime != null
                                    ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                                    : '',
                            'Cover': await MultipartFile.fromFile(
                              _image!.path,
                              filename: fileNameWithExtension,
                            ),
                            'Address': _addressController.text,
                          });

                          orderCubit.createOrder(
                            technicianId: CacheService.getData(
                              key: CacheConstants.technicalId.toString(),
                            ), // Replace with actual ID
                            formData: formData,
                          );
                        },
                        icon:
                            _isSubmitting
                                ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                                : const Icon(
                                  FontAwesomeIcons.paperPlane,
                                  color: Colors.white,
                                  size: 20,
                                ),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            _isSubmitting ? 'جاري الإرسال...' : 'اطلب الآن',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.appColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          shadowColor: ColorManager.appColor.withOpacity(0.2),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(
          color: ColorManager.appColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator:
          (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: ColorManager.appColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ElevatedButton.icon(
      onPressed: _pickDate,
      icon: const Icon(FontAwesomeIcons.calendar, size: 16),
      label: Text(
        _selectedDate == null
            ? 'اختر التاريخ'
            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildTimePicker() {
    return ElevatedButton.icon(
      onPressed: _pickTime,
      icon: const Icon(FontAwesomeIcons.clock, size: 16),
      label: Text(
        _selectedTime == null
            ? 'اختر الوقت'
            : '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        if (_image != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              _image!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () => setState(() => _image = null),
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text(
              'إزالة الصورة',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ] else
          OutlinedButton.icon(
            onPressed: _pickImage,
            icon: Icon(FontAwesomeIcons.image, color: ColorManager.appColor),
            label: const Text('اختر صورة'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: ColorManager.appColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
      ],
    );
  }
}
