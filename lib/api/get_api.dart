import 'dart:convert';

import 'package:http/http.dart';

Future<List> getData(String uri) async {
  Response res = await get(Uri.parse(uri));

  if (res.statusCode == 200) {
    final obj = jsonDecode(res.body);
    return obj;
  } else {
    throw "Unable to retrieve data.";
  }
}