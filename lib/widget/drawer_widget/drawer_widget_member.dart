import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/utils/helper.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/constants/colors.dart';

class DrawerWidgetMember extends StatefulWidget {
  const DrawerWidgetMember({Key? key}) : super(key: key);

  @override
  State<DrawerWidgetMember> createState() => _DrawerWidgetMemberState();
}

class _DrawerWidgetMemberState extends State<DrawerWidgetMember> {
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
            leading: const Icon(Icons.discount),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/offers');
            },
            title: const Text(
              'Offers',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.percent),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/coupons');
            },
            title: const Text(
              'Your Coupons',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.percent),
            iconColor: Colors.white,
            onTap: () {
              if (user?.profile?.data?.subscriptionId == null) {
                Navigator.pushNamed(context, '/subscription');
              } else {
                Navigator.pushNamed(context, '/additional-coupons');
              }
            },
            title: const Text(
              'Additional Coupons',
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
            leading: const Icon(Icons.gamepad),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/spin-wheel');
            },
            title: const Text(
              'Lucky Draw',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.handshake),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/partners');
            },
            title: const Text(
              'Our Partners',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            iconColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, '/subscription');
            },
            title: const Text(
              'Upgrade',
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
