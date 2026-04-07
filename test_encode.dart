import 'package:http/http.dart' as http;

void main() async {
  var url3 = Uri.parse(Uri.encodeFull('https://api.protippz.com/uploads/images/category/1743695193559-images (1).png'));
  var response3 = await http.get(url3);
  print(response3.statusCode);
  
  var url4 = Uri.parse(Uri.encodeFull('https://api.protippz.com/uploads/images/category/1743695293282-WNBA Store.png'));
  var response4 = await http.get(url4);
  print(response4.statusCode);
}
