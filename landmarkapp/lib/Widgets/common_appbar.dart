// common_widgets.dart
// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/Routes/app_routes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Navigation Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () => Get.toNamed(AppRoutes.homeScreen),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('History'),
                  onTap: () => Get.toNamed(AppRoutes.historyScreen),
                ),
                ListTile(
                  leading: const Icon(Icons.place),
                  title: const Text('Nearby Places'),
                  onTap: () => Get.toNamed(AppRoutes.homeScreen),
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                bool logoutConfirmed =
                    await _showLogoutConfirmationDialog(context);
                Get.offAllNamed(AppRoutes.loginScreen);
                if (logoutConfirmed) {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } catch (e) {
                    print('Error while logging out: $e');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future _showLogoutConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          child: Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text('Yes'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
