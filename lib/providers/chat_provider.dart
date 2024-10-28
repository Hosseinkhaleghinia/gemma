import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  final messageController = TextEditingController();

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessageController() {
    messageController.clear();
    notifyListeners();
  }

  Future<void> sendRequest(String message) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = jsonEncode({
      "model": "lmstudio-community/gemma-2-9b-it-GGUF",
      "messages": [
        {
          "role": "system",
          "content":
          "Please respond to the questions I ask in the same language in which they are asked."
        },
        {"role": "user", "content": message}
      ],
      "temperature": 0.7,
      "max_tokens": -1,
      "stream": false,
    });

    var dio = Dio();

    _isLoading = true;
    notifyListeners();

    try {
      Response response = await dio.post(
        'http://192.168.32.77:1234/v1/chat/completions',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        String result = responseData['choices'][0]['message']['content'];
        _messages.add(ChatMessage(text: result, isUser: false));
        _isLoading = false;
        notifyListeners();
      } else {
        addMessage(ChatMessage(
            text: 'Error: ${response.statusCode} ${response.statusMessage}',
            isUser: false));
        _isLoading = false;
      }
    } catch (e) {
      addMessage(ChatMessage(text: 'Error: $e', isUser: false));
      _isLoading = false;
    }
    notifyListeners();
  }
}
