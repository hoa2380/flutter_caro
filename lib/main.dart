import 'package:caro_flutter/src/bindings/home_binding.dart';
import 'package:caro_flutter/src/pages/pages.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(GetMaterialApp(
    title: 'Caro',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.pages,
    home: HomePage(),
    initialBinding: HomeBinding(),
  ));
}
