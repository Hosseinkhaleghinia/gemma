import 'package:flutter/material.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/assets/widgets.dart';
import 'package:gemma/models/model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart'; //*اضافه کردن متن به کلیپبورد
import 'package:gemma/views/login.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class ChatPage2 extends StatefulWidget {
  const ChatPage2({Key? key}) : super(key: key);

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  final messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ChatMessage> messages = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('SAFAII', style: TextStyle(color: blue100Safaii, fontSize: 32),),
          centerTitle: true,
          backgroundColor: backgrand,
          actions: [
            IconButton(onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            }, icon: Icon(Icons.menu_outlined),color: blue100Safaii,)
          ],
          leading: IconButton(onPressed: () {
            
          }, icon: Image.asset('images/add-post.png' , color: blue100Safaii, width: 25,),),

        ),
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width/2.2,
          backgroundColor: Colors.white,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: backgrand,
                  // ),
                  child: InkWell(
                    onTap: (){
                      /// Close Navigation drawer before
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          bottom: 24
                      ),
                      child: Column(
                        children: const[
                          CircleAvatar(
                            radius: 52,
                            backgroundImage:AssetImage('images/document.png')),
                          SizedBox(height: 12,),
                          Text('Safaii',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white
                            ),),
                          const Text('@safaii.com',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('صفحه اصلی'),
                  onTap: () {
                    Navigator.pop(context);
                    // اینجا می‌توانید به صفحه اصلی هدایت کنید
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('تنظیمات'),
                  onTap: () {
                    Navigator.pop(context);
                    // اینجا می‌توانید به صفحه تنظیمات هدایت کنید
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('درباره ما'),
                  onTap: () {
                    Navigator.pop(context);
                    // اینجا می‌توانید به صفحه "درباره ما" هدایت کنید
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => messages[index],
                ),
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // Widget _buildMessageInput() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: messageController,
  //             decoration: InputDecoration(
  //               hintText: 'Enter your message...',
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(width: 2, color: blue100Safaii),
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(width: 2, color: yellow70Safaii),
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           onPressed: _sendMessage,
  //           icon: Icon(Icons.send, color: blue100Safaii),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: backgrand,
            border: Border.all(
                color: blue100Safaii, width: 2, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 100, // حداکثر ارتفاع برای جلوگیری از پر شدن صفحه
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: messageController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  cursorColor: blue100Safaii,
                  decoration: InputDecoration(
                    hintText: 'چطور میتونم کمکت کنم؟',
                    hintStyle: TextStyle(color: blue100Safaii.withOpacity(0.6)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              hoverColor: Colors.red,
              onPressed: _sendMessage,
              icon: Icon(Icons.send, color: blue100Safaii),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: messageController.text,
          isUser: true,
        ));
        isLoading = true;
      });
      sendRequest(messageController.text);
      messageController.clear();
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // استفاده از animateTo برای اسکرول نرم به پایین
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
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
              "Please respond to the questions I ask in the same language in which they are asked. Listen carefully to each question and answer clearly and accurately."
        },
        {"role": "user", "content": message}
      ],
      "temperature": 0.7,
      "max_tokens": -1,
      "stream": false,
    });

    var dio = Dio();

    try {
      Response response = await dio.post(
        'http://192.168.32.77:1234/v1/chat/completions',
        //!'http://10.0.2.2:1234/v1/chat/completions',
        //'http://asdf10.0.2.2:1234/v1/chat/completions',
        //'http://localhost:1234/v1/chat/completions',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        String result = responseData['choices'][0]['message']['content'];
        setState(() {
          messages.add(ChatMessage(text: result, isUser: false));
          isLoading = false;
        });
      } else {
        _handleError('Error: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      _handleError('Error: $e');
    }
  }

  void _handleError(String errorMessage) {
    setState(() {
      messages.add(ChatMessage(text: errorMessage, isUser: false));
      isLoading = false;
    });
  }

}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({Key? key, required this.text, required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthEmpty = MediaQuery.of(context).size.width / 20;

    return getViewText(context);
  }

  Widget getViewText(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                isUser ? 'images/profile-user.png' : 'images/document.png',
                width: isUser ? 25 : 35,
                color: isUser ? blue100Safaii : null,
              ),
              Offstage(offstage: !isUser, child: SizedBox(width: 4.3)),
              Text(
                isUser ? "شما" : "صفایی",
                style: TextStyle(
                    color: blue100Safaii,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUser
                  ? blue20Safaii.withOpacity(0.2)
                  : blue100Safaii.withOpacity(0.1),
              borderRadius: isUser
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(3),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : BorderRadius.only(
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
            ),
            child: SelectableText(
              text,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: isUser ? Colors.black : blue100Safaii,
              ),
            ),
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: text)); // کپی کردن متن به کلیپبورد
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 700),
                        backgroundColor: backgrand.withOpacity(0.0),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 150 , vertical: 80),
                          content: Container(
                            height: 50,
                        decoration: BoxDecoration(
                          color: isUser ? blue20Safaii.withOpacity(0.2):blue100Safaii.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                            child: Text(
                          'کپی شد!',
                          style: TextStyle(color: blue100Safaii, fontSize: 20),
                        )),
                      )),
                    ); // نمایش پیام اطلاع‌رسانی
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    color: blue100Safaii,
                  )),
              InkWell(
                  onTap: () async {
                    final pdf = await _generatePdf(text);
                    await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdf.save(),
                    );
                  },
                  child: Icon(
                Icons.sim_card_download,
                color: blue100Safaii,
              )),
            ],
          )
        ],
      ),
    );
  }
  Future<pw.Document> _generatePdf(text) async {
    final pdf = pw.Document();

    // فونت را از فایل بارگذاری می‌کنیم
    final fontData = await rootBundle.load("fonts/Vazirmatn-Light.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              text,
              style: pw.TextStyle(font: ttf, fontSize: 20),
              textDirection: pw.TextDirection.rtl,
            ),
          );
        },
      ),
    );

    return pdf;
  }

}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // حذف افکت سایه اسکرول
  }
}
