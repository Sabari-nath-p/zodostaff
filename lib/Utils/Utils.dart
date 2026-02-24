import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zodostaff/Utils/apiHandler.dart';

Future<String?> fileUpload(String path, {bool isKey = false}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('${ApiService.baseUrl}file-upload'),
  );
  request.files.add(await http.MultipartFile.fromPath('file', path));

  http.StreamedResponse response = await request.send();

  String body = await response.stream.bytesToString();
  log(body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = json.decode(body);
    return data["data"][(isKey) ? "key" : "url"];
  } else {
    print(response.reasonPhrase);
  }
}
