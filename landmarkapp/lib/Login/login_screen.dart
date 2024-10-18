// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:landmarkapp/Login/login_controller.dart";
import "package:landmarkapp/Routes/app_routes.dart";
import "package:landmarkapp/Widgets/custom_bth.dart";
import "package:landmarkapp/Widgets/custom_textfeild.dart";

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 80),
                          Image.asset(
                            'assets/party.jpg',
                            width: 300.0,
                            height: 300.0,
                          ),
                        ],
                      ),
                    ),
                    MyTextField(
                        hintText: 'Email',
                        obscureText: false,
                        controller: emailController),
                    const SizedBox(height: 10),
                    MyTextField(
                        hintText: 'Password',
                        obscureText: true,
                        controller: passwordController),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      text: 'Login Now',
                      onTap: () async {
                        var correct = await loginController.login(
                            emailAddress: emailController.text,
                            password: passwordController.text);
                        if (correct) {
                          Get.toNamed(AppRoutes.homeScreen);
                        } else {
                          print("Invalid email address or password");
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.registerScreen),
                          child: Text(
                            ' Register Now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
