import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage_two/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../widgets.dart';


class LoginPage extends StatelessWidget {
  LoginProvider? _provider;

  // var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var res;
  bool loading = false, hidePassword = true;

  @override
  Widget build(BuildContext context) {
    _provider = context.read<LoginProvider>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.pinkAccent, Colors.lightGreenAccent])),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  //Animated Text
                  Transform.rotate(
                    angle: -0.3,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Login',
                            textStyle: TextStyle(
                                fontSize: 150, color: Colors.white12)),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  //TextField Containers
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.black12,

                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 10,
                                      offset: Offset(0, 5)),
                                ]),
                            child: Column(
                              children: [
                                Center(
                                    child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  controller: emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    if (val.toString().isEmpty)
                                      return ('Enter email');
                                    else
                                      null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 70,
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    controller: passwordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    obscureText: hidePassword,
                                    validator: (val) {
                                      if (val.toString().isEmpty)
                                        return 'Enter Password';
                                      else if (val.toString().length < 5)
                                        return 'Enter Password maximum 5';
                                      else if (val.toString().length > 15)
                                        return 'Enter Password minimum 15';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                                      hidePassword
                                                    ? hidePassword = false
                                                    : hidePassword = true;

                                            },
                                            icon: Icon(hidePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility)),
                                        hintText: 'Password',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //simple login
                                // loading == true
                                //     ? Center(child: CircularProgressIndicator())
                                //     : GestureDetector(
                                //   onTap: () {
                                //     // if (formKey.currentState!.validate())
                                //     //   apiHit();
                                //   },
                                //Login Container
                                Consumer<LoginProvider>(
                                    builder: (context, value, child) => value
                                            .loading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : GestureDetector(
                                            onTap: () {
                                              _provider!.apiHit(emailController.text.toString(),
                                                  passwordController.text.toString(), context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.pinkAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 75),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
//Function Without Provider Login ApiHit

//   Future<void> apiHit() async {
//     var url = Uri.parse("https://theratap.com:1337/api/v1/user/login");
//     var response = await http.post(url, body: {
//       "email": emailController.text,
//       "password": passwordController.text
//     }).timeout(Duration(seconds: 10));
//     res = jsonDecode(response.body);
//     print(response.body);
//     showMessage(res['message']);
//     if (res['code'] == 200) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => DrawerPage()),
//       );
//     }
//   }
//
//   void showMessage(String message) {
//     final snackBar = SnackBar(
//         content: Text(
//       message,
//       style: TextStyle(
//           fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
//     ));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
