import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/Provider/bottom_nav_provider.dart';
import 'package:whatsapp_downloader/Provider/getStatusProvider.dart';
import 'Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> BottomNavProvider()),
      ChangeNotifierProvider(create: (_)=> GetStatusProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
    );
  }
}
