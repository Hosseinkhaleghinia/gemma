import 'package:flutter/material.dart';
import '../assets/colors.dart';

class startPage extends StatelessWidget {
  const startPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgrand,
          // appBar: AppBar(
          //   backgroundColor: blue100Safaii,
          //   centerTitle: true,
          //   title: Text("Safaii"),
          //   actions: [
          //
          //     IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          //   ],
          //
          // ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text("Welcome to",
                      style: TextStyle(
                          fontSize: 24,
                          color: blue100Safaii,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 20),
                  child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'S',
                            style: TextStyle(color: redSafaii),
                          ),
                          TextSpan(
                            text: 'A',
                            style: TextStyle(color: grey40Safaii),
                          ),
                          TextSpan(
                            text: 'F',
                            style: TextStyle(color: yellow70Safaii),
                          ),
                          TextSpan(
                            text: 'A',
                            style: TextStyle(color: grey40Safaii),
                          ),
                          TextSpan(
                            text: 'I',
                            style: TextStyle(color: blue20Safaii),
                          ),
                          TextSpan(
                            text: 'I',
                            style: TextStyle(color: blue20Safaii),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    "images/document.png",
                    width: 250,
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        elevation: MaterialStatePropertyAll(2),
                        fixedSize: MaterialStatePropertyAll(Size(250, 45)),
                        backgroundColor: MaterialStatePropertyAll(
                          blue20Safaii,
                        )),
                    onPressed: () {},
                    child: Text("ورود")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        elevation: MaterialStatePropertyAll(2),
                        fixedSize: MaterialStatePropertyAll(Size(250, 45)),
                        backgroundColor: MaterialStatePropertyAll(redSafaii)),
                    onPressed: () {},
                    child: Text("ثبت نام"))
              ],
            ),
          )),
    );
  }
}
