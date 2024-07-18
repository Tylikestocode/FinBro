import "dart:convert";
import "package:finbro/data/users.dart";
import "package:http/http.dart" as http;

// Define the function with a proper return type
Future<User?> fetchPerson(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final currentUser = User(data[0], data[0], data[0], data[0]);
      return currentUser;
    } else {
      print('Error Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
