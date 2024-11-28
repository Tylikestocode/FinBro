import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/ui/components/splash_screens.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';

class PasswordEditScreen extends StatefulWidget {
  const PasswordEditScreen({super.key});

  @override
  State<PasswordEditScreen> createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  final _sharedPrefsService = SharedPrefsService();
  final _userService = UserService();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _currentPasswordErrorText;
  String? _newPasswordErrorText;
  String? _confirmPasswordErrorText;

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearErrors() {
    setState(() {
      _currentPasswordErrorText = '';
      _newPasswordErrorText = '';
      _confirmPasswordErrorText = '';
    });
  }

  void _savePassword() async {
    setState(() {
      _clearErrors();
      _isLoading = true;
    });

    if (_currentPasswordController.text.isEmpty) {
      _currentPasswordErrorText = 'Enter current password';
    } else if (_newPasswordController.text.isEmpty) {
      _newPasswordErrorText = 'Enter new password';
    } else if (_confirmPasswordController.text.isEmpty) {
      _confirmPasswordErrorText = 'Please confirm password';
    } else if (_confirmPasswordController.text != _newPasswordController.text) {
      _newPasswordErrorText = 'Passwords do not match';
      _confirmPasswordErrorText = 'Passwords do not match';
    } else {
      int? currentUserId = await _sharedPrefsService.getCurrentUserId();
      ApiResult result = await _userService.getUserById(currentUserId!);

      if (result.success) {
        User currentUser = result.data!;
        if (currentUser.password != _currentPasswordController.text) {
          _currentPasswordErrorText = 'Current password incorrect';
        } else {
          currentUser.password = _newPasswordController.text;
          ApiResult updateResult = await _userService.updateUser(currentUser);
          if (updateResult.success) {
            setState(() {
              _clearErrors();
            });
            if (mounted) {
              Navigator.pop(context, true);
            }
          } else {
            setState(() {
              _currentPasswordErrorText;
              _newPasswordErrorText;
              _confirmPasswordErrorText;
            });
          }
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text('Change Password'),
              backgroundColor: primary,
              foregroundColor: Colors.white,
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: _savePassword,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _currentPasswordController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                errorText: _currentPasswordErrorText,
                                suffixIcon: IconButton(
                                    onPressed: _currentPasswordController.clear,
                                    icon: const Icon(Icons.clear))),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'New Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _newPasswordController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                errorText: _newPasswordErrorText,
                                suffixIcon: IconButton(
                                    onPressed: _newPasswordController.clear,
                                    icon: const Icon(Icons.clear))),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                errorText: _confirmPasswordErrorText,
                                suffixIcon: IconButton(
                                    onPressed: _confirmPasswordController.clear,
                                    icon: const Icon(Icons.clear))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
        if (_isLoading) buildLoadingScreen()
      ],
    );
  }
}
