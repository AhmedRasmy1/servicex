import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/features/orders/presentation/viewmodel/create_review/add_review_cubit.dart';
import 'package:servicex/features/orders/presentation/viewmodel/order/order_cubit.dart';

class CompleteOrdersView extends StatefulWidget {
  const CompleteOrdersView({super.key});

  @override
  State<CompleteOrdersView> createState() => _CompleteOrdersViewState();
}

class _CompleteOrdersViewState extends State<CompleteOrdersView> {
  late CompleteOrderCubit completeOrderCubit;
  late AddReviewCubit addReviewCubit;

  @override
  void initState() {
    super.initState();
    completeOrderCubit = getIt.get<CompleteOrderCubit>();
    addReviewCubit = getIt.get<AddReviewCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => completeOrderCubit..getAllCompletedOrder()),
        BlocProvider(create: (_) => addReviewCubit),
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
              'الطلبات المكتملة',
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
          body: BlocBuilder<CompleteOrderCubit, OrderState>(
            builder: (context, state) {
              if (state is CompleteOrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompleteOrderSuccess) {
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
                              title: 'اسم الفني:',
                              value: order.technicianName!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.clock,
                              color: const Color(0xFF2E2589),
                              title: 'الوقت:',
                              value: order.time!,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.infoCircle,
                              color: const Color(0xFF2E2589),
                              title: 'وصف المشكلة:',
                              value: order.problemDescription!,
                              maxLines: 2,
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.stopwatch,
                              color: const Color(0xFF2E2589),
                              title: 'المدة:',
                              value: '${order.period} ساعة',
                            ),
                            _buildInfoRow(
                              icon: FontAwesomeIcons.moneyBillWave,
                              color: const Color(0xFF2E2589),
                              title: 'السعر:',
                              value: '${order.price} ج.م',
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return BlocProvider.value(
                                        value: context.read<AddReviewCubit>(),
                                        child: _RatingDialog(
                                          technicianName: order.technicianName!,
                                          orderId: order.id!.toString(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E2589),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.star_rate,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'إضافة تقييم للفني',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CompleteOrderFailed) {
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

class _RatingDialog extends StatefulWidget {
  final String technicianName;
  final String orderId;

  const _RatingDialog({required this.technicianName, required this.orderId});

  @override
  State<_RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<_RatingDialog> {
  int selectedStars = 0;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Row(
        children: [
          const Icon(Icons.star, color: Color(0xFF2E2589)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'تقييم الفني: ${widget.technicianName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < selectedStars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    selectedStars = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'أضف تعليقًا (اختياري)',
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء', style: TextStyle(color: Colors.red)),
        ),
        BlocListener<AddReviewCubit, AddReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.addReviewEntity.message ?? 'تم التقييم بنجاح',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AddReviewFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              final rating = selectedStars;
              final comment = commentController.text.trim();
              context.read<AddReviewCubit>().addReview(
                orderId: widget.orderId,
                rating: rating,
                comment: comment,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2589),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'تأكيد التقييم',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
