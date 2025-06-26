import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/features/technician/presentation/viewmodels/technician_profile/technician_profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicianProfileView extends StatefulWidget {
  const TechnicianProfileView({super.key});

  @override
  State<TechnicianProfileView> createState() => _TechnicianProfileViewState();
}

class _TechnicianProfileViewState extends State<TechnicianProfileView> {
  late TechnicianProfileCubit technicianProfileCubit;
  @override
  void initState() {
    super.initState();
    technicianProfileCubit = getIt.get<TechnicianProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    double avatarRadius = isTablet ? 80 : 55;
    double cardPaddingV = isTablet ? 32 : 22;
    double cardPaddingH = isTablet ? 32 : 18;
    double cardElevation = isTablet ? 6 : 3;
    double cardBorderRadius = isTablet ? 24 : 16;
    double containerPaddingV = isTablet ? 36 : 24;
    double containerPaddingH = isTablet ? 28 : 16;
    double profileNameFont = isTablet ? 32 : 24;
    double profileServiceFont = isTablet ? 20 : 16;
    double detailLabelFont = isTablet ? 18 : 15;
    double detailValueFont = isTablet ? 18 : 15;
    double socialIconWidth = isTablet ? screenWidth * 0.06 : screenWidth * 0.08;
    double socialSpacing = isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    double sectionSpacing = isTablet ? 40 : 28;

    return BlocProvider(
      create: (context) => technicianProfileCubit..getTechnicianProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(isTablet ? 32 : 20),
              child: BlocBuilder<
                TechnicianProfileCubit,
                TechnicianProfileState
              >(
                builder: (context, state) {
                  if (state is TechnicianProfileLoading) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is TechnicianProfileError) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is TechnicianProfileSuccess) {
                    final profile = state.technicianProfile;
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isTablet ? 600 : double.infinity,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade800,
                                    Colors.blue.shade400,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(
                                  cardBorderRadius + 12,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade100.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: containerPaddingV + 8,
                                horizontal: containerPaddingH + 4,
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: avatarRadius + 4,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: avatarRadius,
                                          backgroundImage:
                                              profile.image != null &&
                                                      profile.image!.isNotEmpty
                                                  ? NetworkImage(profile.image!)
                                                  : const AssetImage(
                                                        'assets/images/default_avatar.png',
                                                      )
                                                      as ImageProvider,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.blue.shade700,
                                          size: isTablet ? 32 : 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: isTablet ? 22 : 14),
                                  Text(
                                    profile.name ?? "اسم غير متوفر",
                                    style: TextStyle(
                                      fontSize: profileNameFont + 2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.3,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: isTablet ? 10 : 7),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: isTablet ? 10 : 7,
                                      horizontal: isTablet ? 32 : 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.20),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.toolbox,
                                          color: Colors.white,
                                          size: isTablet ? 22 : 16,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          profile.serviceName ??
                                              "الخدمة غير متوفرة",
                                          style: TextStyle(
                                            fontSize: profileServiceFont + 1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (profile.phone != null) ...[
                                    SizedBox(height: isTablet ? 14 : 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: isTablet ? 28 : 20,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          profile.phone!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isTablet ? 20 : 16,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "/ 5.0",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: isTablet ? 16 : 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            Card(
                              elevation: cardElevation,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  cardBorderRadius,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: cardPaddingV,
                                  horizontal: cardPaddingH,
                                ),
                                child: Column(
                                  children: [
                                    _ProfileDetailRow(
                                      icon: Icons.email,
                                      label: "البريد الإلكتروني",
                                      value: profile.email ?? "غير متوفر",
                                      labelFont: detailLabelFont,
                                      valueFont: detailValueFont,
                                    ),
                                    const Divider(),
                                    _ProfileDetailRow(
                                      icon: Icons.phone,
                                      label: "رقم الهاتف",
                                      value: profile.phone ?? "غير متوفر",
                                      labelFont: detailLabelFont,
                                      valueFont: detailValueFont,
                                    ),
                                    const Divider(),
                                    _ProfileDetailRow(
                                      icon: Icons.location_on,
                                      label: "العنوان",
                                      value: profile.address ?? "غير متوفر",
                                      labelFont: detailLabelFont,
                                      valueFont: detailValueFont,
                                    ),
                                    const Divider(),
                                    _ProfileDetailRow(
                                      icon: FontAwesomeIcons.moneyBillWave,
                                      label: "السعر بالساعة",
                                      value: profile.address ?? "غير متوفر",
                                      labelFont: detailLabelFont,
                                      valueFont: detailValueFont,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: isTablet ? 40 : 32),
                            Center(
                              child: Text(
                                'نفسك تعرف أكتر ؟',
                                style: TextStyle(
                                  fontSize: isTablet ? 22 : screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2E2589),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isTablet ? 8 : screenHeight * 0.005,
                            ),
                            Center(
                              child: Text(
                                'تابعونا على',
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : screenWidth * 0.035,
                                  color: const Color(0xFF2E2589),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isTablet ? 16 : screenHeight * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialIcon(
                                  asset: 'assets/images/facebook.png',
                                  url:
                                      'https://www.facebook.com/Ahmedmido232?mibextid=wwXIfr&mibextid=wwXIfr',
                                  width: socialIconWidth,
                                ),
                                SizedBox(width: socialSpacing),
                                _SocialIcon(
                                  asset: 'assets/images/twitter.png',
                                  url:
                                      'https://x.com/ahmedhishamrsmy?s=21&t=YZr6AgTbJ7LlmzcKqdlgFQ',
                                  width: socialIconWidth,
                                ),
                                SizedBox(width: socialSpacing),
                                _SocialIcon(
                                  asset: 'assets/images/whatsapp.png',
                                  url: 'https://wa.me/201154126873',
                                  width: socialIconWidth,
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? 32 : 24),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: constraints.maxHeight,
                    child: const Center(
                      child: Text(
                        'حدث خطأ غير متوقع',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double labelFont;
  final double valueFont;

  const _ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.labelFont = 15,
    this.valueFont = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF2E2589).withOpacity(0.08),
            child: Icon(icon, color: const Color(0xFF2E2589)),
            radius: 18,
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: labelFont,
                color: const Color(0xFF2E2589),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: Colors.black87, fontSize: valueFont),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String asset;
  final String url;
  final double width;

  const _SocialIcon({
    required this.asset,
    required this.url,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(width),
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      child: Image.asset(asset, width: width),
    );
  }
}
