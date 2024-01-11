import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_downloader/Screens/main_activity.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  void navigate(){
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_)=> const MainActivity()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }
}
