import 'package:finbro/ui/components/data_components.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finbro/domain/transaction.dart';
import 'package:finbro/domain/category.dart'; // Assuming this import is correct

class TransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Category> categories;
  final double screenWidth;
  final double screenHeight;

  const TransactionsScreen({
    Key? key,
    required this.transactions,
    required this.categories,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a map of category IDs to category names
    Map<int, String> categoryMap = {
      for (var category in categories) category.id!: category.name
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Transactions",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.only(
                top: screenWidth * 0.08,
                right: screenWidth * 0.05,
                left: screenWidth * 0.05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transactions List',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Full Transaction List
            Expanded(
              child: transactions.isNotEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                child: ListView.builder(
                  itemCount: transactions.length, // Show all transactions
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    // Retrieve category name using categoryMap
                    final categoryName = categoryMap[transaction.categoryId] ?? 'Unknown';

                    return ListViewContentBlock(
                      transaction: transaction,
                      categoryName: categoryName,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      descriptionCutOff: 30, // No cut-off here, so you can show the full description
                    );
                  },
                ),
              )
                  : Center(
                child: Text(
                  'No transactions yet',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
