import 'package:flutter/material.dart';

// import '../../features/auth/presentation/views/login_view.dart';
// import '../../features/home/presentation/views/home_page_view.dart';
// import '../../features/home/presentation/views/product_details_view.dart';

class RoutesManager {
  static const String onBoarding = '/';
  static const String productDetailsPage = '/ProductDetailsPage';
  static const String loginView = '/LoginView';
  static const String productsPage = '/ProductsPage';
  static const String updateProductPage = '/UpdateProductPage';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text("No Route Found")),
            body: const Center(child: Text("No Route Found")),
          ),
    );
  }
}
