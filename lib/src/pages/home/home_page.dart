import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/home.png'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 210,
              ),
              Bouncing(
                  onPress: () {
                    Get.toNamed(Routes.friend);
                  },
                  child: Image.asset(
                    'assets/image/Play onl.png',
                    width: 300,
                  )),
              Bouncing(
                  onPress: () {
                    Get.toNamed(Routes.computer);
                  },
                  child: Image.asset(
                    'assets/image/practice.png',
                    width: 300,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bouncing(
                      onPress: () {},
                      child: Image.asset(
                        'assets/image/fb.png',
                        height: 90,
                        width: 120,
                      )),
                  Bouncing(
                      onPress: () {},
                      child: Image.asset(
                        'assets/image/gg.png',
                        height: 90,
                        width: 120,
                      )),
                  Bouncing(
                      onPress: () {},
                      child: Image.asset(
                        'assets/image/ip.png',
                        height: 90,
                        width: 120,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
