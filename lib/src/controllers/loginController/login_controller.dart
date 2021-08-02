import 'dart:convert';

import 'package:caro_flutter/src/controllers/loginController/login_provider.dart';
import 'package:caro_flutter/src/model/login.dart';
import 'package:caro_flutter/src/pages/home/home_page.dart';
import 'package:caro_flutter/src/pages/login/login_page.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  TextEditingController userNameController;
  TextEditingController passWordController;
  TextEditingController userNameSignupController;
  TextEditingController passWordSignupController;
  TextEditingController emailSignupController;
  var user = Login().obs;
  var _showPassword = true.obs;

  get showPassword => _showPassword.value;

  set showPassword(value) {
    _showPassword.value = value;
  }

  @override
  void onInit() {
    userNameController = TextEditingController();
    passWordController = TextEditingController();
    emailSignupController = TextEditingController();
    userNameSignupController = TextEditingController();
    passWordSignupController = TextEditingController();
    clearTextField();
    super.onInit();
  }

  void login() async {
    if (userNameController.text.isNotEmpty &&
        passWordController.text.isNotEmpty) {
      try {
        isLoading(true);
        var userData = await LoginProvider()
            .loginRequest(userNameController.text, passWordController.text);
        if (login != null) {
          user.value = userData;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', user.value.data.token);
          prefs.setString('userName', user.value.data.user.username);
          if(user.value.data.user.profilePicture.isNotEmpty) {
            prefs.setString('profilePicture', user.value.data.user.profilePicture[0]);
          }
          print(jsonEncode(userData));
          Get.to(() => HomePage());
        }
      } catch (e,track) {
        print(e.toString());
        print(track.toString());

        dialogError();
      } finally {
        isLoading(false);
      }
    } else
      dialogError();
  }

  void signup() async {
    if (userNameSignupController.text.isNotEmpty &&
        passWordSignupController.text.isNotEmpty &&
        emailSignupController.text.isNotEmpty) {
      try {
        isLoading(true);
        var userData = await LoginProvider()
            .signupRequest(userNameSignupController.text, passWordSignupController.text, emailSignupController.text);
        if (login != null) {
          user.value = userData;
          dialogSignInSuccess();
          print(jsonEncode(userData));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        isLoading(false);
      }
    } else
      dialogError();
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(Get.context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
          (Route route) => false,
    );
  }

  dialogSignup() {
    return Get.defaultDialog(
      backgroundColor: Color(0xff73CDD6),
        title: "SignUp",
        titleStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
            fontFamily: 'KaushanScript'
        ),
        content: Column(
          children: [
            ButtonWidget(
              color: Colors.white,
              width: 350,
              child: Center(
                child: TextFormField(
                  controller: userNameSignupController,
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
                  child: TextFormField(
                    obscureText: showPassword,
                    controller: passWordSignupController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffix: GestureDetector(
                          onTap: (){
                            showHidePassword();
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: showPassword ? Colors.grey : Colors.black,
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
            ButtonWidget(
              color: Colors.white,
              width: 350,
              child: Center(
                child: TextFormField(
                  controller: emailSignupController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                  style: TextStyle(fontSize: 18),
                  cursorColor: Color(0xffEA702B),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Bouncing(
              onPress: ()  {
                signup();
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
        ));
  }

  showHidePassword() {
    showPassword = !showPassword;
  }

  dialogError() {
    return Get.defaultDialog(
        title: "Login Failed",
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          children: [
            Text("Please check your username and password!"),
            SizedBox(height: 10),
            Bouncing(
                onPress: () {
                  Get.back();
                },
                child: ButtonWidget(
                  color: Color(0xffE86F2A),
                  width: 100,
                  child: Text(
                    'Okay',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KaushanScript'),
                  ),
                ))
          ],
        ));
  }

  dialogSignInSuccess() {
    return Get.defaultDialog(
        title: "Sign up success",
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          children: [
            Text("Go back to login page to login!"),
            SizedBox(height: 10),
            Bouncing(
                onPress: () {
                  Get.toNamed(Routes.login);
                },
                child: ButtonWidget(
                  color: Color(0xffE86F2A),
                  width: 100,
                  child: Text(
                    'Okay',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KaushanScript'),
                  ),
                ))
          ],
        ));
  }

  clearTextField(){
    emailSignupController.clear();
    userNameSignupController.clear();
    passWordSignupController.clear();
  }
}
