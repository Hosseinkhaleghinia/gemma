import 'package:flutter/material.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/assets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgrand,
        appBar: AppBar(
          backgroundColor: blue100Safaii,
          title: saffaiiName(),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              color: backgrand,
            )
          ],
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.perm_identity_sharp),
            color: backgrand,
          ),
        ),
        body: Container(),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
              color: blue100Safaii,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'images/noun-transaction-7095812.png',
                    color: backgrand,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'images/noun-news-7073885.png',
                    color: backgrand,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home_filled),
                  color: backgrand),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/noun-order-7120881.png',
                      color: backgrand),
                  color: backgrand),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/noun-growth-chart-7183755.png',
                      color: backgrand),
                  color: backgrand),
            ],
          ),
        ),
      ),
    );
  }
}
