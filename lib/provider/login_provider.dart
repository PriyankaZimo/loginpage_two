import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage_two/widgets.dart';

class LoginProvider extends ChangeNotifier {
  var res;
  var loading = false;

  Future<void> apiHit(String email, String passsword, context) async {
    loading = true;
    notifyListeners();
    var url = Uri.parse("https://theratap.com:1337/api/v1/user/login");
    var response = await http.post(url, body: {
      "email": email,
      "password": passsword
    }).timeout(Duration(seconds: 5));
    // print(response.statusCode,);
    print(response.body);
    loading = false;
    notifyListeners();
    res = jsonDecode(response.body);
    showMessage(res['message'], context);
    if (res["code"] == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DrawerPage()));
    }
    // else{
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Blank field not allowed',style: TextStyle(fontSize: 20),),));
    // }
  }

  void showMessage(String message, context) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightGreen),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
