import 'package:sems/admin/model/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router.dart';
import '../utils/admin_drawer.dart';
import 'admin_home.dart';
import '../../profile/views/profile_screen.dart';
import '../../shared/widget/my_app_bar.dart';
import '../../features/scanner/qr_scanner.dart';
import '../../student/views/student_home.dart';

class MyAppBottomBar extends StatefulWidget {
  const MyAppBottomBar({super.key});

  @override
  MyAppBottomBarState createState() => MyAppBottomBarState();
}

class MyAppBottomBarState extends State<MyAppBottomBar> {
  int _selectedIndex = 0;

  // List of pages for the bottom navigation tabs
  final List<Widget> _pages = [
    const AdminHome(),
    const ProfileScreen(
     
    ),
  ];

  // Function to handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// function for QR scanner tab
  void _onItemTappedQR() {
    context.push(AppRoute.semsAiAssistant.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: adminDrawer(context),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
       
        elevation: 4,
        shape: const StadiumBorder(),
        onPressed: _onItemTappedQR,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.chat_bubble),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            activeIcon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            activeIcon: Icon(Icons.account_box_outlined),
            label: 'My Account',
          ),
        ],
      
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      
    );
  }
}
