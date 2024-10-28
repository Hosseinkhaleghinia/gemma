import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/assets/widgets.dart';
import 'package:gemma/views/login.dart';
import 'package:gemma/views/start.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
                top: 90,
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
                top: 280,
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
                          "نام",
                          blue20Safaii,
                          Icon(
                            Icons.perm_identity_sharp,
                            color: blue100Safaii,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        field(
                          "نام خانوادگی",
                          redSafaii,
                          Icon(
                            Icons.family_restroom,
                            color: blue100Safaii,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
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
                            child: Text('ثبت نام')),
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
                                      text: ' ورود ',
                                      style: TextStyle(
                                          color: blue20Safaii,
                                          fontSize: 18,
                                          fontFamily: 'vazir'),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage(),
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
