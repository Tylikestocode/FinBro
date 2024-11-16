import 'package:finbro/ui/components/splash_screens.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:finbro/ui/profile/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ProfileController _profileController = ProfileController();

  bool _isDeleting = false;


  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    await _profileController.loadUser();
    setState(() {
    });
  }

  void updateUser(String title, String attribute, String value) async {
    if (title == 'Password') {
      await _profileController.navigateToPasswordEditScreen(context);
    }
    else {
      await _profileController.navigateToEditScreen(context, title, attribute, value);

    }
    setState(() {

    });
  }

  void deleteAccount() async {
    setState(() {
      _isDeleting = true; // Start loading
    });

    await _profileController.deleteAccount(context);

    setState(() {
      _isDeleting = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        Scaffold(
          backgroundColor: otherColour,
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: primary,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Icon and Username
                Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 80,
                        color: primary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _profileController.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 2,
                  child: Column(
                    children: [
                      _buildListItem('First Name', _profileController.firstName),
                      _buildDivider(),
                      _buildListItem('Last Name', _profileController.lastName),
                      _buildDivider(),
                      _buildListItem('Username', _profileController.username),
                      _buildDivider(),
                      _buildListItem('Email', _profileController.email),
                      _buildDivider(),
                      _buildListItem('Password', ''),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      _profileController.logout(context);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Delete Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to delete your account? This action cannot be undone.',
                              style: TextStyle(color: Colors.black87),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteAccount(); // Trigger the delete process
                                },
                                child: _isDeleting
                          ? const Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                )
                                :
                                const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Loading overlay
        if (_isDeleting)
          buildLoadingScreen()
      ],
    );
  }


  Widget _buildListItem(String label, String value) {
    return InkWell(
      onTap: () {
        updateUser(label, label, value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87, // Keeping label text black for contrast
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: otherColour, // Light blue for value text
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black38, // Keeping the chevron icon neutral
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: otherColour.withOpacity(0.4), // Light blue divider
      height: 1,
      thickness: 1,
    );
  }
}
