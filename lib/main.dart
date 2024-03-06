import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/components/LoginForm.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/PackageInfoService.dart';

void main() async {
    runApp(MyApp());
  await PackageInfoService().init();
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  
   PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginForm(controller : controller , title: 'Portakal Mobile User App'),
    );
  }
}

