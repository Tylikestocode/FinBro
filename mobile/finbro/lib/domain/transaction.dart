class Transaction {
  final int? id;
  double amount;
  String description;
  String? date;
  String? notes;
  int userId;
  int accountId;
  int categoryId;

  Transaction(
      {this.id,
      required this.amount,
      required this.description,
      this.date,
      this.notes,
      required this.userId,
      required this.accountId,
      required this.categoryId});

  // Factory constructor for creating a Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['id'],
        amount: json['amount'],
        description: json['description'],
        date: json['date'],
        notes: json['notes'],
        userId: json['userId'],
        accountId: json['accountId'],
        categoryId: json['categoryId']);
  }

  // Method for converting a Transaction instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date,
      'notes': notes,
      'userId': userId,
      'accountId': accountId,
      'categoryId': categoryId
    };
  }
}
