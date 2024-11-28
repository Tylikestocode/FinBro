import 'package:finbro/ui/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finbro/domain/transaction.dart';
import 'package:finbro/domain/category.dart';
import 'package:intl/intl.dart';

class RecentTransactionsListView extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Category> categories;
  final double screenWidth;
  final double screenHeight;

  const RecentTransactionsListView({
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

    return Container(
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
          // Header
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
                    'Last Transactions',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
                // Make the "See all" text clickable
                GestureDetector(
                  onTap: () {
                    // Navigate to TransactionsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionsScreen(
                          transactions: transactions,
                          categories: categories,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      color: Colors.blue, // Use a color from your theme
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          // Transaction List or "No Transactions Yet" Message
          Expanded(
            child: transactions.isNotEmpty
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: ListView.builder(
                itemCount: transactions.reversed.take(5).length, // Only show top 5 reversed items
                itemBuilder: (context, index) {
                  final reversedTransactions = transactions.reversed.toList();
                  final transaction = reversedTransactions[index];

                  // Retrieve category name using categoryMap
                  final categoryName = categoryMap[transaction.categoryId] ?? 'Unknown';

                  return ListViewContentBlock(
                    transaction: transaction,
                    categoryName: categoryName,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    descriptionCutOff: 15, // Example cut-off length
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
    );
  }
}



class ListViewContentBlock extends StatelessWidget {
  final Transaction transaction;
  final String categoryName; // Add categoryName here
  final double screenWidth;
  final double screenHeight;
  final int descriptionCutOff;

  const ListViewContentBlock({
    Key? key,
    required this.transaction,
    required this.categoryName, // Accept categoryName here
    required this.screenWidth,
    required this.screenHeight,
    this.descriptionCutOff = 15,
  }) : super(key: key);

  // Utility function to format description
  String formatDescription(String description, int cutOff) {
    if (description.length <= cutOff) return description;
    return '${description.substring(0, cutOff)}...';
  }

  // Utility function to format date
  String formatDate(String? rawDate) {
    if (rawDate == null) return 'Unknown Date';
    final DateTime parsedDate = DateTime.parse(rawDate);
    return DateFormat('d MMMM yyyy').format(parsedDate);
  }

  // Utility function to format amount
  Text formatAmount(double amount) {
    final bool isNegative = amount < 0;
    final String amountString = '${isNegative ? '-' : ''}R ${amount.abs().toStringAsFixed(2)}';

    return Text(
      amountString,
      style: GoogleFonts.poppins(
        color: isNegative
            ? const Color.fromRGBO(240, 91, 94, 1) // Red for negative
            : const Color.fromRGBO(76, 175, 80, 1), // Green for positive
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.11, // Adjusted height to fit new layout
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(237, 237, 237, 1)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            // Icon Placeholder (could be customized based on category)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenWidth * 0.15,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(148, 171, 229, 0.54),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            // Transaction Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Description
                    Text(
                      formatDescription(transaction.description, descriptionCutOff),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Category (now using categoryName)
                    Text(
                      categoryName, // Display category name here
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(120, 120, 120, 1),
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Date
                    Text(
                      formatDate(transaction.date),
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(194, 198, 200, 1),
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Amount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: formatAmount(transaction.amount),
            ),
          ],
        ),
      ),
    );
  }
}
