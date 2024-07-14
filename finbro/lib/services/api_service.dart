// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

Future<http.Response> FetchData() {
  return http.get(Uri.parse('http://testvps.us.to:8080/api/people'));
}
