class Transaction {
  final int amount;
  final String description;
  final DateTime date;
  final int accountID;

  Transaction(this.amount, this.description, this.date, this.accountID);

  int getAmount() {
    return amount;
  }

  String getDescription() {
    return description;
  }

  DateTime getDate() {
    return date;
  }

  int getAccountID() {
    return accountID;
  }
}
