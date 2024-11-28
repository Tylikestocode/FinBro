import 'package:flutter/material.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/ui/accounts/edit_account_controller.dart';

class EditAccountScreen extends StatefulWidget {
  final Account account;

  EditAccountScreen({Key? key, required this.account}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final EditAccountController _editAccountController = EditAccountController();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _initialAmountController = TextEditingController();

  bool _isAddButtonEnabled = false;

  String title = "Update Account";
  String buttonText = "Update";

  @override
  void initState() {
    super.initState();
    _accountNameController.addListener(_updateAddButtonState);
    _accountNameController.text = widget.account.name;
    _initialAmountController.text = widget.account.balance!.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _initialAmountController.dispose();
    super.dispose();
  }

  void _updateAddButtonState() {
    setState(() {
      _isAddButtonEnabled = _accountNameController.text.trim().isNotEmpty;
    });
  }

  void _onAddPressed() {
    if (_formKey.currentState!.validate()) {
      final accountName = _accountNameController.text.trim();
      final initialAmount = double.tryParse(_initialAmountController.text) ?? 0.0;

      _editAccountController.editAccount(
        context,
        widget.account.id!,
        accountName,
        initialAmount,
        1,
      );
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteAccount();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount() {
    _editAccountController.deleteAccount(context, widget.account.id!);
  }

  @override
  Widget build(BuildContext context) {
    final isMainAccount = widget.account.name.toLowerCase() == "main";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(27, 48, 100, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(241, 245, 246, 1),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _accountNameController,
                enabled: !isMainAccount, // Disable if the account is "main"
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  labelStyle: const TextStyle(color: Color.fromRGBO(123, 134, 148, 0.65)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Account name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _initialAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Initial Amount',
                  labelStyle: const TextStyle(color: Color.fromRGBO(123, 134, 148, 0.65)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final number = double.tryParse(value);
                    if (number == null || number < 0) {
                      return 'Enter a valid positive number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isAddButtonEnabled ? _onAddPressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 43, 153, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        disabledBackgroundColor: const Color.fromRGBO(123, 134, 148, 0.65),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          buttonText,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  if (!isMainAccount) ...[
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _showDeleteConfirmation,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
