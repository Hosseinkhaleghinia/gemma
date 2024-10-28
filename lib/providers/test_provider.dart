import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gemma/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Test_provider extends ChangeNotifier {

  User? _profile ;

  User? get profile =>_profile;


  Future<void> getData(String token) async{
    print('Token: $token'); // نمایش توکن برای دیباگ
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    var request =
    http.Request('GET', Uri.parse('https://api.nobitex.ir/users/profile'));

    request.headers.addAll(headers);


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decoderesponse = jsonDecode(responseBody);
        var firstName = decoderesponse['profile']['firstName'];
        var lastName = decoderesponse['profile']['lastName'];
        _profile = (User(null , firstName , lastName , null , null , null, null));
  }
      notifyListeners();
}


}
// void getData2(token) async {
//
//
//   print('Token: $token'); // نمایش توکن برای دیباگ
//   var headers = {
//     'Authorization': 'Token $token',
//     'Content-Type': 'application/json',
//   };
//
//   var request =
//   http.Request('GET', Uri.parse('https://api.nobitex.ir/users/profile'));
//
//   request.headers.addAll(headers);
//
//   try {
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var responseBody = await response.stream.bytesToString();
//       var decoderesponse = jsonDecode(responseBody);
//       var firstName = decoderesponse['profile']['firstName'];
//       var lastName = decoderesponse['profile']['lastName'];
//       print('Response: $firstName $lastName'); // نمایش پاسخ API
//     } else {
//       print('Failed with status code: ${response.statusCode}');
//       print(response.reasonPhrase); // نمایش دلیل خطا در صورت وجود
//     }
//   } catch (e) {
//     print('Error: $e'); // مدیریت خطاها
//   }
// }
//fd56c24705ed163a45870bac032fbea98572ca8c
