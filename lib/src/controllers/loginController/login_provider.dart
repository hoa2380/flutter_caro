import 'package:caro_flutter/src/model/login.dart';
import 'package:dio/dio.dart';

class LoginProvider {
  Login login;
  String _urlLogin = 'https://co-caro.herokuapp.com/users/login';
  String _urlSignup = 'https://co-caro.herokuapp.com/users/signup';
  var dio = Dio();

  Future<Login> loginRequest(userName, passWord) async {
    Map<String, dynamic> data = {
      "username": userName,
      "password": passWord
    };
    try {
      final response = await dio.post(
        _urlLogin,
        data: data,
      );
      if(response.statusCode == 200) {
        login = Login.fromJson(response.data);
      } else print('error');
    } on DioError catch (e) {
      print(e.error);
    }
    return login;

  }

  Future<Login> signupRequest(userName, passWord, email) async {
    Map<String, dynamic> data = {
      "username": userName,
      "password": passWord,
      "email": email,
    };
    try {
      final response = await dio.post(
          _urlSignup,
          data: data
      );
      if(response.statusCode == 200) {
        login = Login.fromJson(response.data);
      } else print('error');
    } on DioError catch (e) {
      print(e.error);
    }
    return login;

  }

}