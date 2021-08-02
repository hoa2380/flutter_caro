import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class HomePage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
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
                height: 150,
              ),
              Bouncing(
                  onPress: () {
                    Get.toNamed(Routes.room);
                  },
                  child: Image.asset(
                    'assets/image/Play onl.png',
                    width: 300,
                  )),
              Bouncing(
                  onPress: () async {
                    Get.toNamed(Routes.game);
                  },
                  child: Image.asset(
                    'assets/image/practice.png',
                    width: 300,
                  )),
              Bouncing(
                  onPress: (){
                    controller.logOut();
                  },
                  child: ButtonWidget(
                    color: Color(0xffE86F2A),
                    width: 100,
                    child: Text(
                      'LogOut'.toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Riangriung'),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}