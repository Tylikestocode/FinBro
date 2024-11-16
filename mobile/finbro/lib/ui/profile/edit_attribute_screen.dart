import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/ui/components/splash_screens.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';

class EditAttributeScreen extends StatefulWidget {
  final String title; // Title for the AppBar
  final String attributeLabel; // Label for the attribute
  final String initialValue; // Original value of the attribute

  const EditAttributeScreen({
    super.key,
    required this.title,
    required this.attributeLabel,
    required this.initialValue,
  });

  @override
  State<EditAttributeScreen> createState() => _EditAttributeScreenState();
}

class _EditAttributeScreenState extends State<EditAttributeScreen> {
  final _sharedPrefsService = SharedPrefsService();
  final _userService = UserService();

  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearText() {
    setState(() {
      _controller.clear();
    });
  }

  void _saveAttribute() async {

    setState(() {
      _isLoading = true;
    });

    if (widget.title == 'Username' || widget.title == 'Email') {
      if (_controller.text.isEmpty) {
        setState(() {
          _errorText = 'This field cannot be empty';
          _isLoading = false;
        });
        return;
      }
    }

    int? currentUserId = await _sharedPrefsService.getCurrentUserId();
    ApiResult result = await _userService.getUserById(currentUserId!);

    if (result.success == true) {
      User currentUser = result.user!;
      switch (widget.title) {
        case 'First name':
          currentUser.name = _controller.text.trim();
          break;
        case 'Last Name':
          currentUser.surname = _controller.text.trim();
          break;
        case 'Username':
          currentUser.username = _controller.text.trim();
          break;
        case 'Email':
          currentUser.email = _controller.text.trim().toLowerCase();
          break;
      }

      ApiResult updateResult = await _userService.updateUser(currentUser);
      if (updateResult.success == true) {
        setState(() {
          _errorText = null;
        });
        if (mounted) {
          Navigator.pop(context, _controller.text);
        }
      } else {
        setState(() {
          _errorText = updateResult.errorMessage;
        });
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
            title: Text(widget.title),
            backgroundColor: primary,
            foregroundColor: Colors.white,
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: _saveAttribute,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.attributeLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          errorText: _errorText,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isLoading) buildLoadingScreen()
      ],
    );
  }
}
