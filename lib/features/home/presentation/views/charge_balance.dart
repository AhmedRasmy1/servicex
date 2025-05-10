import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicex/core/common/custom_exception.dart';
import 'package:servicex/core/di/di.dart';
import 'package:servicex/features/home/presentation/viewmodels/my_balance_viewmodel/my_balance_cubit.dart';

class RechargeWalletPage extends StatefulWidget {
  const RechargeWalletPage({super.key});

  @override
  State<RechargeWalletPage> createState() => _RechargeWalletPageState();
}

class _RechargeWalletPageState extends State<RechargeWalletPage> {
  final List<Map<String, String>> vodafoneNumbers = const [
    {'label': 'Vodafone Cash', 'number': '01154126873'},
    {'label': 'Vodafone Cash', 'number': '01018859739'},
  ];

  final List<Map<String, String>> instapayAccounts = const [
    {'label': 'InstaPay', 'number': '01126121268'},
    {'label': 'InstaPay', 'number': '01154126873'},
  ];

  late MyBalanceCubit myBalanceCubit;
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    myBalanceCubit = getIt.get<MyBalanceCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myBalanceCubit,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(FontAwesomeIcons.arrowRight, size: 24),
                        tooltip: 'رجوع',
                      ),
                      const Text(
                        'شحن المحفظة',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const Text(
                    'ارقام Vodafone Cash',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  ...vodafoneNumbers.map(
                    (e) => PaymentCard(
                      logoPath: 'assets/images/vodafone_cash_logo.png',
                      text: e['number']!,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'ارقام Instapay',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  ...instapayAccounts.map(
                    (e) => PaymentCard(
                      logoPath: 'assets/images/instapay.png',
                      text: e['number']!,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    '💡 من خلال الأرقام اللي فوق، تقدر تشحن بالمبلغ اللي يناسبك، وبعدها تواصل مع حد من خدمة العملاء علشان تاخد الكود ويتضاف الرصيد لمحفظتك 👌',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: codeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل كود الشحن';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'ادخل كود الشحن هنا',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.indigo,
                          width: 2,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),

                  BlocListener<MyBalanceCubit, MyBalanceState>(
                    listener: (context, state) {
                      if (state is MyBalanceLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'جاري إعادة تعيين كلمة السر...',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      } else if (state is MyBalanceSuccess) {
                        Navigator.pop(context); // Close loading
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/successicon.svg',
                                        height: 100,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'تم شحن المحفظة بنجاح',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      } else if (state is MyBalanceFailed) {
                        Navigator.pop(context); // Close loading

                        String message;
                        if (state.exception is ServerError) {
                          message =
                              (state.exception as ServerError).serverMessage ??
                              "حدث خطأ في الخادم";
                        } else if (state.exception is NoInternetError) {
                          message = "لا يوجد اتصال بالإنترنت";
                        } else if (state.exception is DioHttpException) {
                          message = "فشل الاتصال بالخادم";
                        } else {
                          message = "حدث خطأ غير متوقع";
                        }

                        showDialog(
                          context: context,
                          builder:
                              (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final code = codeController.text;
                          myBalanceCubit.chargeBalance(code: code);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'اشحن المحفظة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String logoPath;
  final String text;

  const PaymentCard({super.key, required this.logoPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            logoPath,
            height: 60, // كبرته كمان
            width: 60,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
