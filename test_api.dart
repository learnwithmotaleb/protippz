import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var response = await http.get(Uri.parse('https://api.protippz.com/reward-category/get-all'));
  var jsonResponse = jsonDecode(response.body);
  var result = jsonResponse["data"]["result"];
  for (var r in result) {
    print("NAME: ${r["name"]}");
    print("IMAGE: ${r["image"]}");
    print("---");
  }
}
