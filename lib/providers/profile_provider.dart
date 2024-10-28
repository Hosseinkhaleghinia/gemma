// import 'dart:convert'; // برای json.encode
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
//
// class ProfileProvider with ChangeNotifier {
//   var dio = Dio();
//   var profileData;
//   bool isLoading = false;
//
//   Future<void> fetchProfile(String token) async {
//     isLoading = true;
//     notifyListeners();
//
//     var headers = {
//       'Authorization': 'Token $token',
//     };
//
//     try {
//       var response = await dio.request(
//         'https://your-api-url.com/users/profile',  // آدرس URL باید مشخص شود
//         options: Options(
//           method: 'GET',
//           headers: headers,
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         profileData = response.data['profile'];
//         print(json.encode(profileData));
//       } else {
//         print(response.statusMessage);
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
import 'dart:convert'; // برای json.encode
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProfileProvider with ChangeNotifier {
  var dio = Dio();
  var profileData;
  bool isLoading = false;
 // var token = '309ae048d53c5017c4d53f4eee13b7eb1071c5fa';

  Future<void> fetchProfile() async {
    isLoading = true;
    notifyListeners();

    var headers = {
      'Authorization': 'Token 309ae048d53c5017c4d53f4eee13b7eb1071c5fa',
    };

    try {
      var response = await dio.request(
        'https://your-api-url.com/users/profile',  // آدرس URL باید مشخص شود
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        profileData = response.data['profile'];
        print(json.encode(profileData));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}