import 'package:http/http.dart' as http;

void main() async {
  var url1 = Uri.parse('https://api.protippz.com/uploads/images/category/1743695351858-TicketMaster_wordmark.svg.png');
  var res1 = await http.get(url1);
  print(res1.statusCode);
  
  var url2 = Uri.parse(Uri.encodeFull('https://api.protippz.com/uploads/images/category/1743695293282-WNBA Store.png'));
  var res2 = await http.get(url2);
  print(res2.statusCode);
}
