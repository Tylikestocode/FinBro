import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final TextEditingController controller;
  final FocusNode thisFocusNode;
  final Function(bool isConfirmed) onEditTap;
  final bool isEditable;

  const ProfileTextField({
    super.key,
    required this.title,
    this.initialValue,
    required this.controller,
    required this.onEditTap,
    required this.thisFocusNode,
    this.isEditable = false,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          // Divider
          Divider(color: Colors.grey.shade300, height: 1),
          // Bottom section
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.thisFocusNode,
                  enabled: widget.isEditable,
                  style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              // Pencil icon
              IconButton(
                icon: Icon(
                  widget.isEditable ? Icons.check : Icons.edit,
                  color: widget.isEditable ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  widget.onEditTap(!widget.isEditable);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
