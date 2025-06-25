import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/orders/presentation/viewmodel/order/order_cubit.dart';

class PendingOrdersView extends StatefulWidget {
  const PendingOrdersView({super.key});

  @override
  State<PendingOrdersView> createState() => _PendingOrdersViewState();
}

class _PendingOrdersViewState extends State<PendingOrdersView> {
  late PendingOrderCubit pendingOrderCubit;
  late CompleteOrderByCustomerCubit completeOrderByCustomerCubit;
  List<String> completedOrderIds = [];

  @override
  void initState() {
    super.initState();
    pendingOrderCubit = getIt.get<PendingOrderCubit>();
    completeOrderByCustomerCubit = getIt.get<CompleteOrderByCustomerCubit>();
    _loadCompletedOrders();
  }

  void _loadCompletedOrders() {
    final stored = CacheService.getData(key: 'completedOrderIds');
    if (stored is List<String>) {
      completedOrderIds = stored;
    } else if (stored is List<dynamic>) {
      completedOrderIds = stored.map((e) => e.toString()).toList();
    }
  }

  void _saveCompletedOrder(String id) async {
    if (!completedOrderIds.contains(id)) {
      completedOrderIds.add(id);
      await CacheService.setData(
        key: 'completedOrderIds',
        value: completedOrderIds,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => pendingOrderCubit..getAllPendingOrder(),
        ),
        BlocProvider(create: (context) => completeOrderByCustomerCubit),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'الطلبات المعلقة',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 2,
          ),
          body: BlocBuilder<PendingOrderCubit, OrderState>(
            builder: (context, state) {
              if (state is PendingOrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PendingOrderFailed) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is PendingOrderSuccess) {
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
                    final isCompleted = completedOrderIds.contains(
                      order.id.toString(),
                    );

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
                              title: 'اسم الفني:',
                              value: order.technicianName ?? '',
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
                                      borderRadius: BorderRadius.circular(14),
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
                                      completeOrderByCustomerCubit
                                          .completeOrderByCustomer(
                                            orderId: order.id.toString(),
                                          );
                                      _saveCompletedOrder(order.id.toString());
                                      setState(() {});
                                      context
                                          .read<PendingOrderCubit>()
                                          .getAllPendingOrder();
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
                                        borderRadius: BorderRadius.circular(14),
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
