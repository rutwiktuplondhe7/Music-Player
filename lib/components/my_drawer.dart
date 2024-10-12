import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),

            const SizedBox(height: 25),

            //listitle
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.home),
              title: const Text('H O M E'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('S E T T I N G S'),
              onTap: () {
                //pop the drawer
                Navigator.pop(context);

                //go to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
