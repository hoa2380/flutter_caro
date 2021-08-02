import 'package:caro_flutter/src/bindings/login_binding.dart';
import 'package:caro_flutter/src/pages/pages.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(GetMaterialApp(
    title: 'Caro',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.pages,
    home: token != null ? HomePage() : LoginPage(),
    initialBinding: LoginBinding(),
  ));
}
