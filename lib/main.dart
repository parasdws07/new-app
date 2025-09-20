import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/favorite_page.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/user_controller.dart';

void main() {
  // Initialize UserController globally before app runs
  Get.put(UserController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReqRes Favorites',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/favorites', page: () => FavoritePage()),
      ],
    );
  }
}
