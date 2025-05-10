class MyBalanceEntity {
  final String? message;
  final int? newBalance;

  MyBalanceEntity({required this.message, required this.newBalance});
}

class UserProfileEntity {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final int? balance;
  final String? profileImageUrl;

  UserProfileEntity({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.balance,
    required this.profileImageUrl,
  });
}
