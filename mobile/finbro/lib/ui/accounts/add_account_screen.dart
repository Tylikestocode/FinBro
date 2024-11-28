import 'package:finbro/ui/accounts/add_account_controller.dart';
import 'package:flutter/material.dart';

class AddAccountScreen extends StatefulWidget {

  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {

  AddAccountController _addAccountController = AddAccountController();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _initialAmountController = TextEditingController();

  String? _selectedCategory; // To hold the selected category
  bool _isAddButtonEnabled = false;

  String title = "Add New Account";
  String buttonText = "Add";
  String? accountName;
  String? initialAmount;

  // Example list of categories
  List<String> _categories = ['Savings', 'Checking', 'Investment', 'Other'];

  @override
  void initState() {
    super.initState();
    _accountNameController.addListener(_updateAddButtonState);

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
      final selectedCategory = _selectedCategory ?? 'Uncategorized';

      _addAccountController.createAccount(context, accountName, initialAmount, 1);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(27, 48, 100, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(241, 245, 246, 1), // Custom white
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _accountNameController,
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  labelStyle: const TextStyle(color: Color.fromRGBO(123, 134, 148, 0.65)), // Custom grey
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Smooth corners
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
                  labelStyle: const TextStyle(color: Color.fromRGBO(123, 134, 148, 0.65)), // Custom grey
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Smooth corners
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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isAddButtonEnabled ? _onAddPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 43, 153, 1), // Secondary color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Smooth corners
                    ),
                    disabledBackgroundColor: const Color.fromRGBO(123, 134, 148, 0.65), // Custom grey
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
