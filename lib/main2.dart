import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';


class ResponsModel extends StatefulWidget {
  const ResponsModel({super.key});

  @override
  State<ResponsModel> createState() => _ResponsModelState();
}

class _ResponsModelState extends State<ResponsModel> {
  String? result;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sendRequest();
  }

  Future<void> sendRequest() async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
    };
    var data = jsonEncode({
      "model": "lmstudio-community/gemma-2-9b-it-GGUF",
      "messages": [
        {
          "role": "system",
          "content": "Check if it is about cryptocurrency or not, then see which currency it is about in symbols like BTC, then rate it between -5 and +5, -5 = 'very negative' and +5 = 'very positive' and give the output in JSON format --about_crypto:bool--crypto_symbol:string--sentiment:string-- Without any explanation."
        },
        {
          "role": "user",
          "content": "Bitcoin Slides to 66K in Wake of Silk Road BTC Movements, Solana’s SOL Leads Majors Losses"
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
        setState(() {
          result = responseData['choices'][0]['message']['content'][''];
          isLoading = false;
        });
      } else {
        setState(() {
          result = 'Error: ${response.statusCode} ${response.statusMessage}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SAFAII with Gemma 2'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : result != null
            ? Text(result!)
            : ElevatedButton(
          onPressed: sendRequest,
          child: const Text('Retry'),
        ),
      ),
    );
  }
}
