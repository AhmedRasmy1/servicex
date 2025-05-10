import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicex/core/resources/color_manager.dart';

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final Color imageBackgroundColor;
  final String name;
  final String service;
  final int price;
  final double rating;
  final int reviewCount;
  final Color accentColor;
  final IconData bookmarkIcon;

  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.imageBackgroundColor,
    required this.name,
    required this.service,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.accentColor,
    required this.bookmarkIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.2;
    final horizontalMargin = screenWidth * 0.02;
    final horizontalSpacing = screenWidth * 0.03;
    final NumberFormat formatter = NumberFormat('#,###');

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: horizontalMargin),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: imageBackgroundColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),

          SizedBox(width: horizontalSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      bookmarkIcon,
                      color: accentColor,
                      size: screenWidth * 0.05,
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  service,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.appColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01), // Vertical spacing
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.appColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.015), // Vertical spacing
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorManager.appColor,
                      size: screenWidth * 0.04,
                    ),
                    SizedBox(width: screenWidth * 0.01), // Space
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01), // Space
                    Text(
                      '|',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01), // Space
                    Text(
                      '${formatter.format(reviewCount)} تقييم',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
