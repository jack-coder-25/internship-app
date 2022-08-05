import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/utils/helper.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/constants/colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late AuthenticationService authService;
  UserObject? user;

  @override
  void initState() {
    super.initState();
    authService = context.read<AuthenticationService>();
    getUserData();
  }

  void getUserData() async {
    final userObject = await authService.getUser();

    setState(() {
      user = userObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.red,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 12.0,
              bottom: 16.0,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? user!.fullName : "No User Found",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user != null ? user!.email : "No User Found",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_rounded),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.discount),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Offers',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.percent),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Your Coupons',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.percent),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Additional Coupons',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Your Referrals',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Lucky Draw',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.handshake),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Our Partner',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Upgrade',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            iconColor: Colors.white,
            onTap: () {},
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Colors.white,
            onTap: () async {
              try {
                await context.read<AuthenticationService>().signOut();
                if (!mounted) return;
                Navigator.popUntil(context, ModalRoute.withName('/auth'));
              } catch (error) {
                showSnackbar(context, error.toString());
              }
            },
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
