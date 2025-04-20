import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/auth/presentation/views/choose_service_view.dart';

class ChooseUserTypeView extends StatefulWidget {
  const ChooseUserTypeView({super.key});

  @override
  State<ChooseUserTypeView> createState() => _ChooseUserTypeViewState();
}

class _ChooseUserTypeViewState extends State<ChooseUserTypeView> {
  String? selectedUserType;

  void _selectUserType(String type) {
    setState(() {
      selectedUserType = type;
    });
  }

  Future<void> _goToNextPage() async {
    if (selectedUserType != null) {
      await CacheService.setData(
        key: CacheConstants.userType,
        value: selectedUserType,
      );

      if (selectedUserType == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerPage()),
        );
      } else if (selectedUserType == 'Technician') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChooseServiceView()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('من فضلك اختر نوع الحساب')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
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
                    const SizedBox(width: 8),
                    const Text(
                      'هل أنت؟',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildOption(
                              title: 'مستخدم',
                              imagePath: 'assets/images/userr.svg',
                              type: 'Customer',
                              size: size,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildOption(
                              title: 'فني',
                              imagePath: 'assets/images/technician.svg',
                              type: 'Technician',
                              size: size,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.appColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'التالي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String title,
    required String imagePath,
    required String type,
    required Size size,
  }) {
    final isSelected = selectedUserType == type;

    return GestureDetector(
      onTap: () => _selectUserType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: size.width / 2 - 40,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath, height: 60, width: 60),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("صفحة المستخدم")));
  }
}

class TechnicianPage extends StatelessWidget {
  const TechnicianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("صفحة الفني")));
  }
}
