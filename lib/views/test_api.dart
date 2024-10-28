import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemma/models/coinranking_api_server.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  CoinrankingServer _coinrankingServer = CoinrankingServer();
  var _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await _coinrankingServer.getState();
    setState(() {
      _data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          height: 200,
          child: _data == null
              ? SpinKitCircle(
            color: Colors.blue,
            size: 50,
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child:
                          SvgPicture.network(_data['data']['coins'][0]['iconUrl'],fit: BoxFit.contain),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(_data['data']['coins'][0]['symbol']),
                  ],
                ),
        ),
      ),
    ));
  }
}
