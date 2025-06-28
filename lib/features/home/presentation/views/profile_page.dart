import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../orders/presentation/views/complete_order_view.dart';
import '../../../orders/presentation/views/pending_order_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/di/di.dart';
import '../viewmodels/user_profile_view_model/user_profile_cubit.dart';
import 'charge_balance.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    userProfileCubit = getIt.get<UserProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => userProfileCubit..getUserProfile(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileFailed) {
            return Center(
              child: Text(
                state.exception.toString(),
                style: const TextStyle(fontSize: 24),
              ),
            );
          } else if (state is UserProfileSuccess) {
            final userProfile = state.userProfileEntity;
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: const Color(0xFFd0f26f),
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.04,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userProfile.fullName!,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF2E2589),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    userProfile.phoneNumber!,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: screenWidth * 0.08,
                              backgroundImage: NetworkImage(
                                userProfile.profileImageUrl!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // باقي الصفحة Scrollable
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SectionHeader(
                            title: 'حسابي',
                            fontSize: screenWidth * 0.04,
                          ),
                          ProfileListTile(
                            title: 'شحن المحفظة',
                            leadingImage: 'assets/images/credit-card.png',
                            fontSize: screenWidth * 0.04,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const RechargeWalletPage(),
                                ),
                              );
                            },
                            trallingText: userProfile.balance.toString(),
                          ),
                          ProfileListTile(
                            title: 'الطلبات المكتملة',
                            leadingImage: 'assets/images/complete-ordrer.png',
                            fontSize: screenWidth * 0.04,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const CompleteOrdersView(),
                                  ),
                                ),
                          ),
                          ProfileListTile(
                            title: 'الطلبات المعلقة',
                            leadingImage: 'assets/images/pending_order.png',
                            fontSize: screenWidth * 0.04,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const PendingOrdersView(),
                                  ),
                                ),
                          ),
                          // ProfileListTile(
                          //   title: 'العروض',
                          //   leadingImage: 'assets/images/offers.png',
                          //   fontSize: screenWidth * 0.04,
                          // ),
                          ProfileListTile(
                            title: 'الأسئلة الشائعة',
                            leadingImage: 'assets/images/questionmark.png',
                            fontSize: screenWidth * 0.04,
                            onTap: () async {
                              const url = 'https://servicex-741d4.web.app/faq';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                          ),
                          ProfileListTile(
                            title: 'تواصل مع الدعم',
                            leadingImage: 'assets/images/24-hours-service.png',
                            fontSize: screenWidth * 0.04,
                            onTap: () async {
                              const url =
                                  'https://servicex-741d4.web.app/support';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                          ),
                          ProfileListTile(
                            title: 'سياسة الاستخدام',
                            leadingImage: 'assets/images/secured.png',
                            fontSize: screenWidth * 0.04,
                            onTap: () async {
                              const url =
                                  'https://servicex-741d4.web.app/privacy-policy';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Center(
                            child: Text(
                              'نفسك تعرف أكتر ؟',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2E2589),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Center(
                            child: Text(
                              'تابعونا على',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: const Color(0xFF2E2589),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  const url =
                                      'https://www.facebook.com/Ahmedmido232?mibextid=wwXIfr&mibextid=wwXIfr';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(
                                      Uri.parse(url),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                  width: screenWidth * 0.08,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              InkWell(
                                onTap: () async {
                                  const url =
                                      'https://x.com/ahmedhishamrsmy?s=21&t=YZr6AgTbJ7LlmzcKqdlgFQ';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(
                                      Uri.parse(url),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/twitter.png',
                                  width: screenWidth * 0.08,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              InkWell(
                                onTap: () async {
                                  const url = 'https://wa.me/201154126873';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(
                                      Uri.parse(url),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/whatsapp.png',
                                  width: screenWidth * 0.08,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final double fontSize;

  const SectionHeader({super.key, required this.title, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xff575757),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? leadingImage;
  final Widget? subtitle;
  final double fontSize;
  final void Function()? onTap;
  final String? trallingText;

  const ProfileListTile({
    super.key,
    required this.title,
    this.icon,
    this.leadingImage,
    this.subtitle,
    required this.fontSize,
    this.onTap,
    this.trallingText = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          leading:
              leadingImage != null
                  ? Image.asset(
                    leadingImage!,
                    width: 30,
                    height: 30,
                    color: const Color(0xFF2E2589),
                  )
                  : Icon(icon, color: const Color(0xFF2E2589), size: 30),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF2E2589),
              fontSize: fontSize,
            ),
          ),
          subtitle: subtitle,
          trailing:
              trallingText != null && trallingText!.isNotEmpty
                  ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF5FB),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '$trallingText ج.م',
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF0C478F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Color.fromARGB(255, 190, 190, 190),
        thickness: 0.6,
        height: 16,
      ),
    );
  }
}
