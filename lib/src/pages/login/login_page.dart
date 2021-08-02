import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/home.png'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
              ),
              ButtonWidget(
                color: Colors.white,
                width: 350,
                child: Center(
                  child: TextField(
                    controller: controller.userNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'User Name',
                    ),
                    style: TextStyle(fontSize: 18),
                    cursorColor: Color(0xffEA702B),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GetX<LoginController> (
               builder: (_) {
                 return ButtonWidget(
                   color: Colors.white,
                   width: 350,
                   child: TextField(
                     obscureText: controller.showPassword,
                     controller: controller.passWordController,
                     decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: 'Password',
                         suffix: GestureDetector(
                           onTap: (){
                             controller.showHidePassword();
                           },
                           child: Icon(
                             Icons.remove_red_eye,
                             color: controller.showPassword ? Colors.grey : Colors.black,
                           ),
                         )
                     ),
                     style: TextStyle(fontSize: 20),
                     cursorColor: Color(0xffEA702B),
                   ),
                 );
               },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Bouncing(
                    onPress: (){
                      controller.login();
                    },
                    child: ButtonWidget(
                        color: Color(0xffE86F2A),
                        width: 100,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
                        )
                    ),
                  ),
                  Bouncing(
                    onPress: (){
                      controller.dialogSignup();
                    },
                    child: ButtonWidget(
                        color: Color(0xffE86F2A),
                        width: 100,
                        child: Text(
                          'SignIn',
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
                        )
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bouncing(
                      onPress: () {
                      },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
