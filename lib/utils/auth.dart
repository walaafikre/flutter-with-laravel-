import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_laravel_test/models/user.dart';
import 'package:flutter_laravel_test/utils/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  bool _isSignedIn = false;
  User _user;
  String _token;

  bool get authenticated => _isSignedIn;
  User get user => _user;

  final storage = new FlutterSecureStorage();

  void signIn({Map creds}) async {
    print(creds);

    Dio.Response response = await dio().post('/sanctum/token', data: creds);
    print(response.data.toString());

    String token = response.data.toString();
    this.tryToken(token: token);

    _isSignedIn = true;
    notifyListeners();
  }

  void tryToken({String token}) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        this._isSignedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;
        this.storeToken(token: token);
        notifyListeners();
        print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken({String token}) async {
    this.storage.write(key: 'token', value: token);
  }

  void signOut() async {
    try {
      Dio.Response response = await dio().get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));

      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    this._user = null;
    this._isSignedIn = false;
    this._token = null;
    await storage.delete(key: 'token');
  }
}
