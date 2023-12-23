import 'dart:convert';

import 'package:http/http.dart' as http;

class ChargilyApi {
  static chargilyApi() async {
    var url = Uri.parse('http://epay.chargily.com.dz/api/invoice');

    var headers = {
      'X-Authorization': 'api_p2YZRTFP7AX9Vvc5t0aJt9YUkxVjg7owp5yxU7h54Vjc39lTQZCuZLt9UAZekBIU',
      'Accept': 'application/json'
    };

    var body = {
      'client': 'fsdfsdf',
      'client_email': 'sfsdf@sdfds.com',
      'invoice_number': '1010',
      'amount': '5000',
      'discount': '0',
      'back_url': 'https://google.com',
      'webhook_url': 'https://google.com',
      'mode': 'CIB',
      'comment': 'sdfsdf'
    };

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);
  }
}
