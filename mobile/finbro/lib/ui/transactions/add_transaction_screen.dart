import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/domain/category.dart';
import 'package:finbro/domain/transaction.dart';
import 'package:finbro/service/category_service.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/transaction_service.dart';
import 'package:finbro/ui/components/snack_bar_message.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  final Account selectedAccount; // Account object passed when navigating

  const AddTransactionScreen({Key? key, required this.selectedAccount})
      : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _sharedPrefsService = SharedPrefsService();
  final _categoryService = CategoryService();
  final _transactionService = TransactionService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _transactionNameController = TextEditingController();
  bool _isIncome = true;
  final _snackBarMessage = SnackBarMessage();

  List<Category> _allCategories = [];
  Category? selectedCategory; // Store the selected category object

  bool get _isAddButtonEnabled {
    return _amountController.text.isNotEmpty && selectedCategory != null;
  }

  @override
  void initState() {
    super.initState();
    // Set default transaction name
    _transactionNameController.text = _isIncome
        ? 'Income in ${widget.selectedAccount.name}'
        : "Expense in ${widget.selectedAccount.name}";
    loadCategories();
  }

  Future<void> loadCategories() async {
    ApiResult result = await _categoryService.getAllPredefinedCategories();
    if (result.success) {
      setState(() {
        _allCategories = result.data;
      });
    }
  }

  void _openCategoryBottomSheet() {
    // Show bottom sheet with the list of categories
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrolling of the sheet
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400, // Set a height for the bottom sheet
          child: ListView.builder(
            itemCount: _allCategories.length,
            itemBuilder: (context, index) {
              final category = _allCategories[index];
              return ListTile(
                title: Text(category.name), // Display category name
                onTap: () {
                  setState(() {
                    selectedCategory = category; // Set selected category
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(27, 48, 100, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Form Content
            Expanded(
              child: SingleChildScrollView(
                // Allow scrolling for form content
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey, // Attach the GlobalKey to the Form widget
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures content doesn't take more space than needed
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Name Display
                      Text(
                        widget.selectedAccount.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(27, 48, 100, 1),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Amount Text Field
                      Center(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(123, 134, 148, 0.65)),
                            filled: true,
                            fillColor: _isIncome
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Amount is required';
                            }
                            final number = double.tryParse(value);
                            if (number == null || number <= 0) {
                              return 'Enter a valid positive amount';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Income/Expense Toggle Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isIncome = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isIncome ? Colors.green : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text('Income'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isIncome = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  !_isIncome ? Colors.red : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text('Expense'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),

                      // Transaction Name Text Field (Optional)
                      TextFormField(
                        controller: _transactionNameController,
                        decoration: InputDecoration(
                          labelText: 'Transaction Name (Optional)',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(123, 134, 148, 0.65),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Category Selection Text (Now triggers Bottom Sheet)
                      GestureDetector(
                        onTap: _openCategoryBottomSheet, // Trigger bottom sheet
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  selectedCategory?.name ?? 'Select Category',
                                  style: TextStyle(
                                    color: selectedCategory == null
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0), // Space before the button
                    ],
                  ),
                ),
              ),
            ),

            // Add Button at the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isAddButtonEnabled ? _onAddPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 43, 153, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    disabledBackgroundColor:
                        const Color.fromRGBO(123, 134, 148, 0.65),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: const Text(
                      'Add Transaction',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddPressed() async {
    int? currentUserId = await _sharedPrefsService.getCurrentUserId();

    print(_formKey.currentState!.validate());

    if (_formKey.currentState?.validate() ?? false) {

      double totalAmount = double.tryParse(_amountController.text) ?? 0.0;

      if (!_isIncome) {
        totalAmount =
            -totalAmount; // If it's an expense, make the amount negative
      }

      String transactionName = _transactionNameController.text.trim();
      if (transactionName.isEmpty || transactionName == "Income in ${widget.selectedAccount.name}" || transactionName == "Expense in ${widget.selectedAccount.name}") {
        transactionName = _isIncome ?
        "Income in ${widget.selectedAccount.name}" :
        "Expense in ${widget.selectedAccount.name}";
      }

      Category? category = selectedCategory;

      Transaction transaction = Transaction(
          amount: totalAmount,
          description: transactionName,
          userId: currentUserId!,
          accountId: widget.selectedAccount.id!,
          categoryId: category!.id!,
          notes: "");

      ApiResult result =
          await _transactionService.createTransaction(transaction);
      if (result.success) {
        Navigator.pop(context, true);
      } else {
        _snackBarMessage.showSnackBarMessage(context, result.errorMessage!);
      }
    }
  }
}
