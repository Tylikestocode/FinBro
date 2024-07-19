import 'dart:convert';
import 'package:finbro/data/data.dart';
import 'package:http/http.dart' as http;

Future fetchUser(email) async {
  String loginUrl = 'http://testvps.us.to:8080/api/users/getByEmail/$email';

  try {
    var response = await http.get(Uri.parse(loginUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var user = Credentials.fromJson(data);
      return user;
    } else {
      print('Error while fetching data Error Code: ${response.statusCode}');
    }
  } catch (e) {
    print(e);
  }
}

Future loginUser(email, password) async {
  var user = await fetchUser(email);
  if (password == user.password) {
    return true;
  } else {
    return false;
  }
}
