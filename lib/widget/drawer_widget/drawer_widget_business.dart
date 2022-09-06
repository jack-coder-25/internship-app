import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mci/utils/helper.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/constants/colors.dart';

class DrawerWidgetBusiness extends StatefulWidget {
  const DrawerWidgetBusiness({Key? key}) : super(key: key);

  @override
  State<DrawerWidgetBusiness> createState() => _DrawerWidgetBusinessState();
}

class _DrawerWidgetBusinessState extends State<DrawerWidgetBusiness> {
  UserObject? user;

  @override
  void initState() {
    super.initState();

    setState(() {
      user = context.read<UserObject?>();
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
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 64.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user != null ? user!.fullName : "...",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user != null ? user!.email : "...",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/package-subscription');
            },
            title: const Text(
              'Package Subscription',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/referrals');
            },
            title: const Text(
              'Your Referrals',
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
