import 'package:finbro/ui/accounts/accounts_screen.dart';
import 'package:finbro/ui/profile/profile_screen.dart';
import 'package:finbro/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'ui_colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: customWhite, // Set background to customWhite for a clean look
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with a primary or secondary color background
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primary, // Use the primary color for bold contrast
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), // Rounded bottom-left corner
                bottomRight: Radius.circular(20), // Rounded bottom-right corner
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'FinBro Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Make the title bold for impact
                ),
              ),
            ),
          ),
          // ListTile for Home
          ListTile(
            tileColor: customWhite, // Light background for the ListTile
            contentPadding: EdgeInsets.symmetric(horizontal: 20), // Add padding
            leading: Icon(Icons.home, color: secondary), // Icon with secondary color
            title: const Text(
              'Home',
              style: TextStyle(
                color: primary, // Use primary color for text to maintain contrast
                fontSize: 18,
                fontWeight: FontWeight.w500, // Slightly bold for emphasis
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          // ListTile for Accounts
          ListTile(
            tileColor: customWhite,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(Icons.account_balance_wallet, color: secondary),
            title: const Text(
              'Accounts',
              style: TextStyle(
                color: primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountsScreen(),
                ),
              );
            },
          ),
          // ListTile for Profile
          ListTile(
            tileColor: customWhite,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(Icons.person, color: secondary),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
