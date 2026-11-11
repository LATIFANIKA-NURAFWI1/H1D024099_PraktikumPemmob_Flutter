import 'package:flutter/material.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({super.key});

  void _navigateReplacement(BuildContext context, String routeName) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    Navigator.pop(context);
    if (currentRoute != routeName) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Sidemenu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _navigateReplacement(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => _navigateReplacement(context, '/about'),
          ),
        ],
      ),
    );
  }
}
