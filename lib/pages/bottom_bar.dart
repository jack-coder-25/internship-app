import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/pages/bookings.dart';
import 'package:app/pages/home/home_wrapper.dart';
import 'package:app/pages/notifications.dart';
import 'package:app/pages/support.dart';
import 'package:app/pages/wallet.dart';
import 'package:app/widget/drawer_widget/drawer_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void setSelectedIndex(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    const List<String> items = [
      'Home',
      'Bookings',
      'Wallet',
      'Notifications',
      'Support',
    ];

    List<SingleChildWidget> providers = [
      Provider<void Function(int)>(create: (_) => setSelectedIndex),
      Provider<List<String>>(create: (_) => items),
    ];

    List<Widget> pages = [
      MultiProvider(
        providers: providers,
        child: const HomeWrapper(),
      ),
      const BookingsPage(),
      const WalletPage(),
      const NotificationsPage(),
      const SupportPage(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(items.elementAt(selectedIndex)),
        backgroundColor: ColorConstants.red,
      ),
      drawer: const DrawerWrapper(),
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: ColorConstants.red,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Support",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
