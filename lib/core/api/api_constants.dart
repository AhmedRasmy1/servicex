class ApiConstants {
  static const String baseUrl = 'https://servicex.runasp.net/';
  static const String login = 'api/auth/login';
  static const String sentOtp = 'api/Auth/forget-password';
  static const String verifyOtp = 'api/Auth/verify-otp';
  static const String resetPassword = 'api/Auth/reset-password';
  static const String register = 'api/auth/register';
  static const String getAllServices = 'api/service';
  static const String charegeBalance = 'api/CodesForCharges/applyCode';
  static const String getUserProfile = 'api/CustomerProfile/me';
  static const String getTechnicianProfile = 'api/TechnicalProfile/me';
  static const String topServices = 'api/order/top-services';
  static const String getTechniciansForServices =
      'api/Review/service/{serviceId}/technicians-with-reviews';
  static const String createOrder = 'api/order/{technicianId}';
  static const String getAllPendingOrder = 'api/order/my-orders/pending';
  static const String getAllCompletedOrder = 'api/order/my-orders/completed';
  static const String completeOrderByCustomer =
      'api/order/complete-by-customer/{orderId}';
  static const String completeOrderByTechnician =
      'api/order/complete-by-technician/{orderId}';
  static const String getAllCompletedOrderForTechnician =
      'api/order/technician-orders/completed';
  static const String getAllPendingOrderForTechnician =
      'api/order/technician-orders/pending';
  static const String addReviewByUser = 'api/Review';
}
