import 'package:flutter/material.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/providers/profile_provider.dart';
import 'package:gemma/providers/test_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => Test_provider(),
      child: Consumer<Test_provider>(
        builder: (context, profile, child) => ProfilePage2(
          height: height,
          width: width,
          profile: profile,
        ),
      ),
    );
    // return ProfilePage2(height: height, width: width);
  }

}

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({
    super.key,
    required this.height,
    required this.width,
    required this.profile,
  });

  final double height;
  final double width;
  final Test_provider profile;

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  @override
  void initState() {
    super.initState();
    // دریافت داده در initState
    widget.profile.getData('fd56c24705ed163a45870bac032fbea98572ca8c');
  }

  @override
  Widget build(BuildContext context) {
    var profile = widget.profile.profile;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: widget.height * 0.2,
                width: widget.width * 0.9,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      redSafaii,
                      redSafaii.withOpacity(0.8),
                      redSafaii.withOpacity(0.6),
                      redSafaii.withOpacity(0.4),
                      redSafaii.withOpacity(0.2),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        minRadius: widget.width * 0.1,
                        backgroundColor: blue20Safaii,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          profile?.firstName ?? '',
                          style: TextStyle(color: blue100Safaii, fontSize: 18),
                        ),
                        Text(
                          profile?.lastName ?? '',
                          style: TextStyle(color: blue100Safaii, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
