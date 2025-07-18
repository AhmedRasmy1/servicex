import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../domain/entities/service_entity.dart';
import '../viewmodels/services_viewmodel/services_cubit.dart';
import '../../../orders/presentation/views/create_order_view.dart';
import 'package:shimmer/shimmer.dart';

class TechniciansView extends StatefulWidget {
  const TechniciansView({super.key});

  @override
  State<TechniciansView> createState() => _TechniciansViewState();
}

class _TechniciansViewState extends State<TechniciansView> {
  late TechniciansForServicesCubit techniciansForServicesCubit;
  final serviceId = CacheService.getData(key: CacheConstants.serviceId);

  @override
  void initState() {
    super.initState();
    techniciansForServicesCubit = getIt.get<TechniciansForServicesCubit>();
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  double _getMainAxisExtent(double width) {
    if (width >= 1200) return 340;
    if (width >= 900) return 340;
    if (width >= 600) return 340;
    return 430;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              techniciansForServicesCubit..getTechniciansForServices(
                serviceId != null ? serviceId.toString() : '',
              ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF2F6FC),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'الفنيين المتاحين',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = _getCrossAxisCount(width);
              final mainAxisExtent = _getMainAxisExtent(width);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<TechniciansForServicesCubit, ServicesState>(
                  builder: (context, state) {
                    if (state is TechniciansForServicesLoading) {
                      return _buildShimmer(crossAxisCount, mainAxisExtent);
                    } else if (state is TechniciansForServicesSuccess) {
                      return GridView.builder(
                        itemCount: state.techniciansForServices.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: mainAxisExtent,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                        ),
                        itemBuilder: (context, index) {
                          final tech = state.techniciansForServices[index];
                          return _TechnicianCard(tech: tech);
                        },
                      );
                    } else if (state is TechniciansForServicesFailed) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(int crossAxisCount, double mainAxisExtent) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: crossAxisCount * 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisExtent: mainAxisExtent,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 14),
                    Container(height: 14, width: 90, color: Colors.white),
                    const SizedBox(height: 12),
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TechnicianCard extends StatelessWidget {
  final TechniciansForServicesEntity tech;
  const _TechnicianCard({required this.tech});

  @override
  Widget build(BuildContext context) {
    final reviews = tech.reviews ?? [];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 7,
      shadowColor: ColorManager.appColor.withOpacity(0.12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: InteractiveViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    tech.imageUrl ?? '',
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            CircleAvatar(
                                              radius: 80,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: const Icon(
                                                Icons.person,
                                                size: 80,
                                                color: Colors.grey,
                                              ),
                                            ),
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        height: 160,
                                        width: 160,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(38),
                    child: Image.network(
                      tech.imageUrl ?? '',
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person,
                              size: 38,
                              color: Colors.grey,
                            ),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey.shade200,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Tooltip(
                  message: "موثق",
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.appColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.all(2.4),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              tech.fullName ?? '',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222B45),
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ColorManager.appColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorManager.appColor, width: 1),
              ),
              child: Text(
                tech.serviceName ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.appColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            _infoRow(FontAwesomeIcons.phone, tech.phone ?? '', context),
            const SizedBox(height: 4),
            _infoRow(FontAwesomeIcons.locationDot, tech.address ?? '', context),
            const SizedBox(height: 4),
            _infoRow(
              FontAwesomeIcons.sackDollar,
              '${tech.payByHour ?? ''} جنيه/ساعة',
              context,
              color: ColorManager.appColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < (tech.averageRating ?? 0).floor()
                        ? Icons.star
                        : (i < (tech.averageRating ?? 0)
                            ? Icons.star_half
                            : Icons.star_border),
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${(tech.averageRating ?? 0).toStringAsFixed(1)} / 5.0',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF444E5E),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${tech.totalReviews ?? 0})',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 2, height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.7,
                              minWidth: 300,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'كل التقييمات',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ColorManager.appColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child:
                                      reviews.isEmpty
                                          ? Center(
                                            child: Text(
                                              'لا توجد تقييمات متوفرة',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                          : ListView.separated(
                                            itemCount: reviews.length,
                                            separatorBuilder:
                                                (_, __) =>
                                                    const SizedBox(height: 8),
                                            itemBuilder: (context, idx) {
                                              final review = reviews[idx];
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6,
                                                    ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      review.ratingValue
                                                              ?.toString() ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            review.comments ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                    0xFF444E5E,
                                                                  ),
                                                                ),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            '- ${review.customerName ?? ''}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors
                                                                      .grey
                                                                      .shade600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.appColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'إغلاق',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 0,
                ),
                icon: const Icon(Icons.reviews, size: 18, color: Colors.white),
                label: const Text(
                  'عرض التقييمات',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  CacheService.setData(
                    key: CacheConstants.technicalId,
                    value: tech.technicalId,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateOrderView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                ),
                icon: const Icon(
                  FontAwesomeIcons.calendarCheck,
                  size: 18,
                  color: Colors.white,
                ),
                label: const Text(
                  'احجز الآن',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) {
    return Row(
      children: [
        Icon(icon, size: 15, color: ColorManager.appColor.withOpacity(0.7)),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: color ?? const Color(0xFF444E5E),
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
