import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/features/home/presentation/viewmodels/services_viewmodel/services_cubit.dart';
import 'package:servicex/features/home/presentation/viewmodels/user_profile_view_model/user_profile_cubit.dart';
import 'package:servicex/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:servicex/features/home/presentation/widgets/most_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ServicesCubit servicesCubit;
  late UserProfileCubit userProfileCubit;
  @override
  void initState() {
    super.initState();
    servicesCubit = getIt.get<ServicesCubit>();
    userProfileCubit = getIt.get<UserProfileCubit>();
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => servicesCubit..getAllServices()),
        BlocProvider(create: (context) => userProfileCubit..getUserProfile()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF2E2589),
        body: Stack(
          children: [
            BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileSuccess) {
                  final userName = state.userProfileEntity.fullName;
                  final userBalance =
                      state.userProfileEntity.balance.toString();
                  return Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                      userName: userName!,
                      userBalance: userBalance,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Positioned(
              top: screenHeight * 0.1,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: TopEdgeCurveClipper(),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const OffersSlider(),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Text(
                              'الخدمات',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Add your navigation or action logic here
                                print('عرض الكل clicked');
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'عرض الكل',
                                    style: TextStyle(
                                      color: ColorManager.appColor,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: screenWidth * 0.04,
                                    color: ColorManager.appColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        SizedBox(
                          height: screenHeight * 0.11,
                          child: BlocBuilder<ServicesCubit, ServicesState>(
                            builder: (context, state) {
                              if (state is ServicesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ServicesSuccess) {
                                final services = state.services;

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      services
                                          .length, // Replace with the actual number of items
                                  itemBuilder: (context, index) {
                                    return Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: screenWidth * 0.3,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.01,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9F9F9),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                              255,
                                              235,
                                              235,
                                              235,
                                            ), // Related border color
                                            width: 2, // Border width
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                255,
                                                210,
                                                210,
                                                210,
                                              ).withOpacity(0.2),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.network(
                                                services[index].imageUrl,
                                                height: screenHeight * 0.04,
                                                width: screenHeight * 0.04,
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                services[index].name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is ServicesFailed) {
                                return const Center(
                                  child: Text('Failed to load services'),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Text(
                              'أكثر الخدمات طلبًا',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Add your navigation or action logic here
                                print('عرض الكل clicked');
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'عرض الكل',
                                    style: TextStyle(
                                      color: ColorManager.appColor,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: screenWidth * 0.04,
                                    color: ColorManager.appColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return ServiceCard(
                              imagePath: 'assets/images/defaulttechnician.png',
                              imageBackgroundColor: Colors.white,
                              name: 'محمد',
                              accentColor: const Color(0xFF2E2589),
                              service: 'خدمة 1',
                              price: 100,
                              rating: 4.5,
                              reviewCount: 120,
                              bookmarkIcon: Icons.bookmark_border,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopEdgeCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 15;
    final path = Path();
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, String>> offers = [
      {
        'title': 'خصم 30%',
        'subtitle': 'عرض اليوم!',
        'desc': 'احصل على خصم على كل طلب، العرض ساري اليوم فقط',
        'image': 'assets/images/defaulttechnician.png',
      },
      {
        'title': 'خصم 50%',
        'subtitle': 'عرض خاص!',
        'desc': 'عروض الصيف تبدأ الآن، لا تفوت الفرصة!',
        'image': 'assets/images/defaulttechnician.png',
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عروض خاصة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Add your navigation or action logic here
                  print('عرض الكل clicked');
                },
                child: Row(
                  children: [
                    const Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: ColorManager.appColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ColorManager.appColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02),
          CarouselSlider(
            options: CarouselOptions(
              height: screenWidth * 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.95, // Increased the width slightly
            ),
            items:
                offers.map((offer) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7B61FF), Color(0xFF8E7BFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offer['title']!,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: screenWidth * 0.01),
                                    Text(
                                      offer['subtitle']!,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: screenWidth * 0.015),
                                    Text(
                                      offer['desc']!,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.asset(
                                offer['image']!,
                                height: screenWidth * 0.35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
