import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/di/di.dart';
import '../viewmodel/order/order_cubit.dart';

class CompletedOrderPageForTechnician extends StatefulWidget {
  const CompletedOrderPageForTechnician({super.key});

  @override
  State<CompletedOrderPageForTechnician> createState() =>
      _CompletedOrderPageForTechnicianState();
}

class _CompletedOrderPageForTechnicianState
    extends State<CompletedOrderPageForTechnician> {
  late CompleteOrderForTechnicianCubit completeOrderForTechnicianCubit;

  @override
  void initState() {
    super.initState();
    completeOrderForTechnicianCubit =
        getIt.get<CompleteOrderForTechnicianCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => completeOrderForTechnicianCubit..getCompletedOrders(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          //   title: const Text(
          //     'الطلبات المكتملة',
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
          body: BlocBuilder<CompleteOrderForTechnicianCubit, OrderState>(
            builder: (context, state) {
              if (state is CompleteOrderForTechnicianLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompleteOrderForTechnicianSuccess) {
                final orders = state.completedOrders;
                if (orders.isEmpty) {
                  return const Center(
                    child: Text('لا يوجد طلبات مكتملة حتي الآن'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
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
                                    order.serviceName!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFd0f26f),
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
                                        order.date!,
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
                              color: const Color(0xFF2E2589),
                              title: 'العنوان:',
                              value: order.address!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.userTie,
                              color: const Color(0xFF2E2589),
                              title: 'اسم العميل:',
                              value: order.userName!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.phone,
                              color: const Color(0xFF2E2589),
                              title: 'رقم الهاتف:',
                              value: order.phone!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.clock,
                              color: const Color(0xFF2E2589),
                              title: 'الوقت:',
                              value: order.time!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.infoCircle,
                              color: Color(0xFF2E2589),
                              title: 'وصف المشكلة:',
                              value: order.problemDescription!,
                              maxLines: 2,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.stopwatch,
                              color: Color(0xFF2E2589),
                              title: 'المدة:',
                              value: '${order.period} ساعة',
                              maxLines: 2,
                            ),

                            _buildInfoRow(
                              icon: FontAwesomeIcons.moneyBillWave,
                              color: const Color(0xFF2E2589),
                              title: 'السعر:',
                              value: '${order.price} ج.م',
                            ),
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
                                            backgroundColor: Colors.transparent,
                                            child: InteractiveViewer(
                                              minScale: 0.5,
                                              maxScale: 4,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
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
                                          child: CircularProgressIndicator(),
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CompleteOrderForTechnicianFailed) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('لا توجد طلبات مكتملة.'));
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
