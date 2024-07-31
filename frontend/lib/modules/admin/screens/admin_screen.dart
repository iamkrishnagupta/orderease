import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/modules/admin/screens/admin_dashboard_screen.dart';
import 'package:frontend/modules/admin/screens/admin_home_screen.dart';
import 'package:frontend/modules/admin/screens/ordered_food_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _currentPageIndex = 0; // More descriptive variable name
  final double _bottomBarWidth = 42; // Made constant since it does not change
  final double _bottomBarBorderWidth =
      5; // Made constant since it does not change

  final List<Widget> _pages = [
    const AdminHomeScreen(),
    const ChartPage(),
    const OrderedFoodScreen(),
  ];

  void _updatePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.purple,
        title: const Text('OrderEase Admin'),
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: _updatePage,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavBarItem(Icons.home_outlined, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarItem(Icons.analytics_outlined, 1),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarItem(Icons.all_inbox_outlined, 2),
            label: 'Orders',
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
    return Container(
      width: _bottomBarWidth,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                _currentPageIndex == index ? Colors.teal : Colors.transparent,
            width: _bottomBarBorderWidth,
          ),
        ),
      ),
      child: Icon(icon),
    );
  }
}
