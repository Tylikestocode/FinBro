class Category {
  final int? id;
  String name;
  String type;
  String? description;
  bool isUserDefined;
  int? userId;

  Category(
      {this.id,
      required this.name,
      required this.type,
      this.description,
      required this.isUserDefined,
      this.userId});

  // Factory constructor for creating a Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
        name: json['name'],
        type: json['type'],
        description: json['description'],
        userId: json['userId'],
        isUserDefined: json['userDefined']
    );
  }

  // Method for converting a Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'type': type,
      'description': description,
      'userId': userId,
      'userDefined': isUserDefined
    };
  }

}
