import 'dart:convert';
import 'package:dio/dio.dart';
//import 'dart:js_interop';

Future<void> sendRequest() async {
  var headers = {
    'Content-Type': 'application/json',
  };
  var data = jsonEncode({
    "model": "lmstudio-community/gemma-2-9b-it-GGUF",
    "messages": [
      {
        "role": "system",
        "content":
        "Please respond to the questions I ask in the same language in which they are asked. Listen carefully to each question and answer clearly and accurately."
      },
      {
        "role": "user",
        "content": "فرمول شیمیایی آب چیه؟"
      }
    ],
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": false,
  });

  var dio = Dio();

  try {
    Response response = await dio.post(
      'http://10.0.2.2:1234/v1/chat/completions',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;

      print("Message: ${responseData['choices'][0]['message']['content']['']}");
    } else {
      print('Error: ${response.statusCode} ${response.statusMessage}');
    }
  } catch (e) {
    print('Error: $e');
  }
}