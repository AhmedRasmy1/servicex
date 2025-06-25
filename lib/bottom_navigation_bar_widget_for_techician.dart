import 'package:flutter/material.dart';
import 'package:servicex/features/orders/presentation/views/completed_order_page_for_technician.dart';
import 'package:servicex/features/orders/presentation/views/pending_order_page_for_technician.dart';
import 'package:servicex/features/technician/presentation/views/technician_profile_view.dart';
import 'core/resources/color_manager.dart';

class TechnicianNavigationPage extends StatefulWidget {
  const TechnicianNavigationPage({super.key});

  @override
  State<TechnicianNavigationPage> createState() =>
      _TechnicianNavigationPageState();
}

class _TechnicianNavigationPageState extends State<TechnicianNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    PendingOrderPageForTechnician(),
    CompletedOrderPageForTechnician(),
    TechnicianProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedItemColor: ColorManager.appColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined),
              activeIcon: Icon(Icons.schedule, size: 30),
              label: 'الطلبات المعلقة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              activeIcon: Icon(Icons.check_circle, size: 30),
              label: 'الطلبات المكتملة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, size: 30),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}
