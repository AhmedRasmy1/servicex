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
  static const String topServices = 'api/order/top-services';
  static const String getTechniciansForServices =
      'api/service/{serviceId}/technicians';
}
