import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/auth/presentation/views/register_for_technician.dart';
import 'package:servicex/features/home/presentation/viewmodels/services_viewmodel/services_cubit.dart';

class ChooseServiceView extends StatefulWidget {
  const ChooseServiceView({super.key});

  @override
  State<ChooseServiceView> createState() => _ChooseServiceViewState();
}

class _ChooseServiceViewState extends State<ChooseServiceView> {
  late ServicesCubit servicesCubit;
  int? selectedIndex;

  void _selectCard(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _goToNextPage() async {
    if (selectedIndex != null) {
      final serviceId =
          servicesCubit.state is ServicesSuccess
              ? (servicesCubit.state as ServicesSuccess)
                  .services[selectedIndex!]
                  .id
              : null;

      if (serviceId != null) {
        await CacheService.setData(
          key: CacheConstants.technichianService,
          value: serviceId.toString(),
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegisterForTechnicianbView()),
      );
    } else {
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
                    Icon(Icons.error_outline, color: Colors.red, size: 40),
                    SizedBox(height: 20),
                    Text(
                      'يرجى اختيار الخدمة',
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
    }
    log(CacheService.getData(key: CacheConstants.technichianService));
  }

  @override
  void initState() {
    servicesCubit = getIt.get<ServicesCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicesCubit..getAllServices(),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and back button
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
                        'ما الخدمة التي ستقدمها؟',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Service cards
                  Expanded(
                    child: BlocBuilder<ServicesCubit, ServicesState>(
                      builder: (context, state) {
                        if (state is ServicesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ServicesSuccess) {
                          final services = state.services;

                          return GridView.builder(
                            itemCount: services.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.9,
                                ),
                            itemBuilder: (context, index) {
                              final isSelected = selectedIndex == index;
                              final service = services[index];

                              return GestureDetector(
                                onTap: () => _selectCard(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.blue
                                              : Colors.grey.shade300,
                                      width: 2,
                                    ),
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
                                      Hero(
                                        tag: service.id,
                                        child: SvgPicture.network(
                                          service.imageUrl,
                                          height: 60,
                                          width: 60,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.broken_image,
                                                    size: 60,
                                                    color: Colors.grey,
                                                  ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        service.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? Colors.blue
                                                  : Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is ServicesFailed) {
                          return Center(
                            child: Text(
                              'فشل في تحميل الخدمات',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: ColorManager.appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'التالي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
