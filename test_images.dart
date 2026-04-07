import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('https://api.protippz.com/uploads/images/category/1743695293282-WNBA%20Store.png');
  var response = await http.get(url);
  print("URL 1: \${response.statusCode}");
  
  var url2 = Uri.parse('https://api.protippz.com/uploads/images/category/1743695193559-images%20(1).png');
  var response2 = await http.get(url2);
  print("URL 2: \${response2.statusCode}");
  
  var url3 = Uri.parse(Uri.encodeFull('https://api.protippz.com/uploads/images/category/1743695193559-images (1).png'));
  var response3 = await http.get(url3);
  print("Encode full: \${response3.statusCode}");
}
