import 'package:decimal/decimal.dart';

class Account {
  final int? id;
  String name;
  bool? allowNegativeBalance;
  double? minimumBalance;
  double? balance;
  String? dateCreated;
  String? notes;
  int userId;
  int categoryId;

  Account(
      {this.id,
      required this.name,
      this.allowNegativeBalance = true,
      this.minimumBalance,
      required this.balance,
      this.dateCreated,
      this.notes = '',
      required this.userId,
      required this.categoryId});

  // Factory constructor for creating an Account from JSON
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['id'],
        name: json['name'],
        allowNegativeBalance: json['allowNegativeBalance'],
        minimumBalance: json['minimumBalance'],
        balance: (json['balance']),
        dateCreated: json['dateCreated'],
        notes: json['notes'],
        userId: json['userId'],
        categoryId: json['categoryId']);
  }

  // Method for converting an Account instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'allowNegativeBalance': allowNegativeBalance,
      'minimumBalance': minimumBalance,
      'balance': balance,
      'dateCreated': dateCreated,
      'notes': notes,
      'userId': userId,
      'categoryId': categoryId
    };
  }

  @override
  String toString() {
    return 'Account'
        '{id: $id, \n'
        'name: $name, \n'
        'allowNegativeBalance: $allowNegativeBalance, \n'
        'minimumBalance: $minimumBalance, \n'
        'balance: $balance, \n'
        'dateCreated: $dateCreated, \n'
        'notes: $notes, \n'
        'userId: $userId, \n'
        'categoryId: $categoryId, \n}';
  }

}
