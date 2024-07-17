import "dart:convert";
import "package:finbro/data/users.dart";
import "package:http/http.dart" as http;

// Define the function with a proper return type
Future<User?> fetchPerson(String url) async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        var currentUser = User(
          data[0]['name'],
          data[0]['surname'],
          data[0]['age'],
          data[0]['email'],
        );
        return currentUser;
      } else {
        print('No data found');
        return null;
      }
    } else {
      print('Response failed with status code ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
