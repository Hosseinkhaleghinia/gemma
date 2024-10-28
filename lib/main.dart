import 'package:flutter/material.dart';
import 'package:gemma/models/crypto_state.dart';
import 'package:gemma/providers/crypto_data_provider.dart';
import 'package:gemma/providers/profile_provider.dart';
import 'package:gemma/views/chat_page2.dart';
import 'package:gemma/views/chat_page.dart';
import 'package:gemma/views/markets/main_market.dart';
import 'package:gemma/views/markets/page_tab/crypto_list.dart';
import 'package:gemma/views/home_page.dart';
import 'package:gemma/views/markets/page_tab/market_map.dart';
import 'package:gemma/views/profile.dart';
import 'package:gemma/views/signup.dart';
import 'package:gemma/views/login.dart';
import 'package:gemma/views/start.dart';
import 'package:gemma/views/test_api.dart';
import 'package:gemma/views/markets/page_tab/crypto_list.dart';
import 'assets/colors.dart';
import 'package:provider/provider.dart';

import 'models/coinranking_api_server.dart';

// void main() async {
//   final api = CoinrankingServer();
//   final result = await api.getState();
//   print('Test result: $result');
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CryptoDataProvider(),
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'vazir'),
      home: MainMarkets(),
    );
  }
}

  // static final List<Crypto> testData = [
  //   Crypto("bitcoin", "4000", 2.4, "3400000", null, null, null, null,
  //       null, null, null, null, null, null, "BTC1", null),
  //   Crypto("bitcoin1", "400000000", 1, "34333300", null, null, null, null,
  //       null, null, null, null, null, null, "BTC2", null),
  //   Crypto("bitcoin2", "43300", -1.2, "23440000", null, null, null, null, null,
  //       null, null, null, null, null, "BTC3", null),
  //   // Crypto("bitcoin3", "422000", -3.4, "34000000", null, null, null, null, null,
  //   //     null, null, null, null, null, "BTC4", null),
  //   // Crypto("bitcoin4", "4456000", 0.4, "4000", null, null, null, null, null,
  //   //     null, null, null, null, null, "BTC5", null),
  //   // Crypto("bitcoin5", "400", -2.4, "350000", null, null, null, null, null,
  //   //     null, null, null, null, null, "BTC6", null),
  //   // Crypto("bitcoin6", "80000", 22.4, "500000", null, null, null, null, null,
  //   //     null, null, null, null, null, "BTC7", null),
  //   // Crypto("bitcoin7", "1lr0000", -0.4, "34000000", null, null, null, null,
  //   //     null, null, null, null, null, null, "BTC8", null),
  // ];


// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:dio/dio.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String? result;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     sendRequest();
//   }
//
//   Future<void> sendRequest() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     var headers = {
//       'Content-Type': 'application/json',
//     };
//     var data = jsonEncode({
//       "model": "lmstudio-community/gemma-2-9b-it-GGUF",
//       "messages": [
//         {
//           "role": "system",
//           "content":
//           "Please respond to the questions I ask in the same language in which they are asked. Listen carefully to each question and answer clearly and accurately."
//
//         },
//         {
//           "role": "user",
//           "content": "فرمول شیمیای آب چیه؟"
//         }
//       ],
//       "temperature": 0.7,
//       "max_tokens": -1,
//       "stream": false,
//     });
//
//     var dio = Dio();
//
//     try {
//       Response response = await dio.post(
//         'http://10.0.2.2:1234/v1/chat/completions',
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> responseData = response.data;
//         setState(() {
//           result = responseData['choices'][0]['message']['content'];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           result = 'Error: ${response.statusCode} ${response.statusMessage}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         result = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('SAFAII with Gemma 2'),
//       ),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : result != null
//             ? Text(result!)
//             : ElevatedButton(
//           onPressed: sendRequest,
//           child: const Text('Retry'),
//         ),
//       ),
//     );
//   }
// }
