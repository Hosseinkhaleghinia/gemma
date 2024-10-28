import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/assets/widgets.dart';
import 'package:gemma/views/signup.dart';
import 'package:gemma/views/start.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgrand,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 110,
                left: (MediaQuery.of(context).size.width / 2) - 75,
                width: 150,
                child: Container(
                  child: Image.asset(
                    'images/document.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                width: 280,
                top: 320,
                left: (MediaQuery.of(context).size.width - 280) / 2,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   child: Text(
                        //     'ورود' , textAlign: TextAlign.center, style: TextStyle(color: blue100Safaii , fontWeight: FontWeight.bold ,
                        //   fontSize: 50),
                        //   ),
                        // ),SizedBox(height: 30,),
                        field(
                            "ایمیل",
                            blue20Safaii,
                            Icon(
                              Icons.email,
                              color: blue100Safaii,
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        field(
                          "رمز عبور",
                          redSafaii,
                          Icon(
                            Icons.password_outlined,
                            color: blue100Safaii,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                hoverColor: blue20Safaii,
                                highlightColor: blue20Safaii.withOpacity(0.1),
                                onTap: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => startPage(),));
                                },
                                child: Text('فراموشی رمز عبور',
                                    style: TextStyle(
                                        color: redSafaii,
                                        fontSize: 13,
                                        fontFamily: 'vazir')),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(4),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                backgroundColor:
                                    MaterialStatePropertyAll(blue100Safaii),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(280, 45))),
                            onPressed: () {},
                            child: Text('ورود')),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStatePropertyAll(4),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(blue100Safaii),
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(135, 45))),
                              onPressed: () {},
                              child: Container(
                                child: Image.asset(
                                  "images/google.png",
                                  height: 36,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStatePropertyAll(4),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(blue100Safaii),
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(135, 45))),
                              onPressed: () {},
                              child: Container(
                                child: Image.asset(
                                  "images/apple-logo.png",
                                  color: Colors.white,
                                  height: 36,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'برای ایجاد حساب کاربری',
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13,
                                      fontFamily: 'vazir'),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' ثبت نام ',
                                      style: TextStyle(
                                          color: blue20Safaii,
                                          fontSize: 18,
                                          fontFamily: 'vazir'),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => signup(),
                                              ));
                                        },
                                    ),
                                    TextSpan(
                                      text: 'کنید',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 13,
                                          fontFamily: 'vazir'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
