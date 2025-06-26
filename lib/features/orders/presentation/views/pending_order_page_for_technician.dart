import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/orders/presentation/viewmodel/order/order_cubit.dart';

class PendingOrderPageForTechnician extends StatefulWidget {
  const PendingOrderPageForTechnician({super.key});

  @override
  State<PendingOrderPageForTechnician> createState() =>
      _PendingOrderPageForTechnicianState();
}

class _PendingOrderPageForTechnicianState
    extends State<PendingOrderPageForTechnician> {
  late PendingOrderForTechnicianCubit pendingOrderForTechnicianCubit;
  late CompleteOrderByTechnicianCubit completeOrderByTechnicianCubit;
  List<String> completedOrderIdsTechnician = [];

  @override
  void initState() {
    super.initState();
    pendingOrderForTechnicianCubit =
        getIt.get<PendingOrderForTechnicianCubit>();
    completeOrderByTechnicianCubit =
        getIt.get<CompleteOrderByTechnicianCubit>();
    _loadCompletedOrders();
  }

  void _loadCompletedOrders() {
    final stored = CacheService.getData(key: 'completedOrderIdsTechnician');
    if (stored is List<String>) {
      completedOrderIdsTechnician = stored;
    } else if (stored is List<dynamic>) {
      completedOrderIdsTechnician = stored.map((e) => e.toString()).toList();
    }
  }

  void _saveCompletedOrder(String id) async {
    if (!completedOrderIdsTechnician.contains(id)) {
      completedOrderIdsTechnician.add(id);
      await CacheService.setData(
        key: 'completedOrderIdsTechnician',
        value: completedOrderIdsTechnician,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  pendingOrderForTechnicianCubit
                    ..getPendingOrdersForTechnician(),
        ),
        BlocProvider(create: (context) => completeOrderByTechnicianCubit),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          //   title: const Text(
          //     'الطلبات المعلقة',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 22,
          //       letterSpacing: 1,
          //     ),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: Colors.white,
          //   foregroundColor: Colors.black,
          //   elevation: 2,
          // ),
          body: BlocConsumer<CompleteOrderByTechnicianCubit, OrderState>(
            listener: (context, state) {
              if (state is CompleteOrderByTechnicianSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                _saveCompletedOrder(state.completedOrderId);
                context
                    .read<PendingOrderForTechnicianCubit>()
                    .getPendingOrdersForTechnician();
              }
              if (state is CompleteOrderByTechnicianFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return BlocBuilder<PendingOrderForTechnicianCubit, OrderState>(
                builder: (context, state) {
                  if (state is PendingOrderForTechnicianLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PendingOrderForTechnicianFailed) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is PendingOrderForTechnicianSuccess) {
                    final pendingOrders = state.pendingOrders;
                    if (pendingOrders.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا توجد طلبات معلقة',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: pendingOrders.length,
                      itemBuilder: (context, index) {
                        final order = pendingOrders[index];
                        final isCompleted = completedOrderIdsTechnician
                            .contains(order.id.toString());

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.blue.shade50],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue.shade50,
                                      child: const Icon(
                                        FontAwesomeIcons.toolbox,
                                        color: Color(0xFF2E2589),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        order.serviceName ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFd0f26f),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.clock,
                                            size: 13,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            order.date ?? '',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                _buildInfoRow(
                                  icon: FontAwesomeIcons.mapMarkerAlt,
                                  color: Color(0xFF2E2589),
                                  title: 'العنوان:',
                                  value: order.address ?? '',
                                ),
                                _buildInfoRow(
                                  icon: FontAwesomeIcons.userTie,
                                  color: Color(0xFF2E2589),
                                  title: 'اسم العميل:',
                                  value: order.technicianName ?? '',
                                ),
                                _buildInfoRow(
                                  icon: FontAwesomeIcons.phoneAlt,
                                  color: Color(0xFF2E2589),
                                  title: 'رقم العميل:',
                                  value: order.phone ?? '',
                                ),
                                _buildInfoRow(
                                  icon: FontAwesomeIcons.clock,
                                  color: Color(0xFF2E2589),
                                  title: 'الوقت:',
                                  value: order.time ?? '',
                                ),
                                _buildInfoRow(
                                  icon: FontAwesomeIcons.infoCircle,
                                  color: const Color(0xFF2E2589),
                                  title: 'وصف المشكلة:',
                                  value: order.problemDescription ?? '',
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 10),
                                if (order.imageUrl != null &&
                                    order.imageUrl!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (_) => Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: InteractiveViewer(
                                                  minScale: 0.5,
                                                  maxScale: 4,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    child: Image.network(
                                                      order.imageUrl!,
                                                      fit: BoxFit.contain,
                                                      loadingBuilder: (
                                                        context,
                                                        child,
                                                        loadingProgress,
                                                      ) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      },
                                                      errorBuilder: (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return const Center(
                                                          child: Text(
                                                            'فشل تحميل الصورة',
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          order.imageUrl!,
                                          fit: BoxFit.fill,
                                          height: 180,
                                          width: double.infinity,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return const Center(
                                              child: Text('فشل تحميل الصورة'),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (isCompleted)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2E2589),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.check,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'تم الاكتمال',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              final controller =
                                                  TextEditingController();
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                title: Row(
                                                  children: const [
                                                    Icon(
                                                      FontAwesomeIcons.clock,
                                                      color: Color(0xFF2E2589),
                                                      size: 22,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'مدة العمل (بالساعات)',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'يرجى إدخال عدد الساعات التي استغرقتها لإكمال الطلب:',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller: controller,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                          FontAwesomeIcons
                                                              .hourglassHalf,
                                                          color: Color(
                                                            0xFF2E2589,
                                                          ),
                                                          size: 18,
                                                        ),
                                                        hintText: 'مثال: 2',
                                                        filled: true,
                                                        fillColor:
                                                            Colors.blue.shade50,
                                                        contentPadding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 12,
                                                            ),
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actionsPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8,
                                                    ),
                                                actions: [
                                                  TextButton.icon(
                                                    icon: const Icon(
                                                      FontAwesomeIcons.times,
                                                      color: Colors.red,
                                                      size: 16,
                                                    ),
                                                    label: const Text(
                                                      'إلغاء',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed:
                                                        () => Navigator.pop(
                                                          context,
                                                        ),
                                                  ),
                                                  ElevatedButton.icon(
                                                    icon: const Icon(
                                                      FontAwesomeIcons.check,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    label: const Text(
                                                      'تأكيد الاكتمال',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                            0xFF2E2589,
                                                          ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 18,
                                                            vertical: 10,
                                                          ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      final period =
                                                          int.tryParse(
                                                            controller.text,
                                                          );
                                                      if (period != null &&
                                                          period > 0) {
                                                        completeOrderByTechnicianCubit
                                                            .completeOrderByTechnician(
                                                              orderId:
                                                                  order.id
                                                                      .toString(),
                                                              period: period,
                                                            );
                                                        Navigator.pop(context);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'يرجى إدخال مدة صحيحة (عدد ساعات أكبر من 0)',
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            255,
                                            17,
                                            0,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'إكتمال الطلب',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 17),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
