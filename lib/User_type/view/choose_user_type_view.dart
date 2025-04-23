import 'package:flutter/material.dart';
import 'package:servicex/User_type/widgets/user_type_button.dart';
import 'package:servicex/User_type/widgets/user_type_option.dart';
import 'package:servicex/core/resources/app_constants.dart';
import 'package:servicex/core/resources/assets_manager.dart';
import 'package:servicex/core/resources/constants_text_app.dart';
import 'package:servicex/core/resources/custom_app_bar.dart';
import 'package:servicex/core/resources/custom_error_dialog.dart';
import '../../core/utils/cashed_data_shared_preferences.dart';
import '../../features/auth/presentation/views/choose_service_view.dart';
import '../../features/auth/presentation/views/register_for_customer.dart';

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

      if (selectedUserType == AppConstants.customerType) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterForCustomerView(),
          ),
        );
      } else if (selectedUserType == AppConstants.technicianType) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChooseServiceView()),
        );
      }
    } else {
      showDialog(
        context: context,
        builder:
            (context) => const ErrorDialog(
              message: ConstantsText.selectAccountTypeError,
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(context: context),
                const SizedBox(height: 30),
                Expanded(child: _buildUserTypeOptions(size)),
                const SizedBox(height: 10),
                AppButton(text: ConstantsText.next, onPressed: _goToNextPage),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeOptions(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: UserTypeOption(
                title: ConstantsText.user,
                imagePath: AssetsManager.userIcon,
                isSelected: selectedUserType == AppConstants.customerType,
                onTap: () => _selectUserType(AppConstants.customerType),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: UserTypeOption(
                title: ConstantsText.technician,
                imagePath: AssetsManager.technicianIcon,
                isSelected: selectedUserType == AppConstants.technicianType,
                onTap: () => _selectUserType(AppConstants.technicianType),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
