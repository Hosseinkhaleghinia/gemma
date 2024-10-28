import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../models/chat_message.dart';
import 'package:gemma/assets/colors.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewPage();
  }
}
//? یکم دیگه ریسپانسیو رو کار کنم بعدش برم سراغ apiو نوشتن مدل‌هایی که تو برنامه بتونم ازشون استفاده کنم
//!یکم دیگم ویدیو های ادیبی رو گوش کنم ببینم به کجا میرسم
class ViewPage extends StatefulWidget {
  const ViewPage({
    super.key,
  });

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'SAFAII',
              style: TextStyle(color: blue100Safaii, fontSize: 32),
            ),
            centerTitle: true,
            backgroundColor: backgrand,
            actions: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.menu_outlined),
                color: blue100Safaii,
              )
            ],
            leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/add-post.png',
                color: blue100Safaii,
                width: 25,
              ),
            ),
          ),
          body: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        ChatMessage message = chatProvider.messages[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? Colors.blue[50]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                                color: message.isUser
                                    ? Colors.blue
                                    : Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                  if (chatProvider.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatProvider.messageController,
                            decoration: InputDecoration(
                              hintText: 'چطور میتونم کمکت کنم؟',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            String message =
                                chatProvider.messageController.text;
                            if (message.isNotEmpty) {
                              chatProvider.addMessage(
                                  ChatMessage(text: message, isUser: true));
                              chatProvider.clearMessageController();
                              chatProvider.sendRequest(message);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
