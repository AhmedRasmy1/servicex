import 'package:flutter/material.dart';
import 'core/resources/color_manager.dart';
import 'features/home/presentation/views/home_page.dart';
import 'features/home/presentation/views/profile_page.dart';

class MainNavigationPageForCustomer extends StatefulWidget {
  const MainNavigationPageForCustomer({super.key});

  @override
  State<MainNavigationPageForCustomer> createState() =>
      _MainNavigationPageForCustomerState();
}

class _MainNavigationPageForCustomerState
    extends State<MainNavigationPageForCustomer> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [HomePage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Custom shadow for navigation bar
  BoxDecoration _navBarDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: _navBarDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              selectedItemColor: ColorManager.appColor,
              unselectedItemColor: Colors.grey.shade400,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      vertical: _selectedIndex == 0 ? 4 : 0,
                    ),
                    child: Icon(
                      _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                      size: _selectedIndex == 0 ? 30 : 26,
                    ),
                  ),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      vertical: _selectedIndex == 1 ? 4 : 0,
                    ),
                    child: Icon(
                      _selectedIndex == 1 ? Icons.person : Icons.person_outline,
                      size: _selectedIndex == 1 ? 30 : 26,
                    ),
                  ),
                  label: 'حسابي',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
