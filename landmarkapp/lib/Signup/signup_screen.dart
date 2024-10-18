// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/Routes/app_routes.dart';
import 'package:landmarkapp/Signup/signup_controller.dart';
import 'package:landmarkapp/Widgets/custom_bth.dart';
import 'package:landmarkapp/Widgets/custom_textfeild.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final signUpController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0), // Add this line
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image(image: AssetImage('assets/SignUpPage.jpg')),
                  ),
                  const SizedBox(height: 30),
                  MyTextField(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Password',
                      obscureText: false,
                      controller: passwordController),
                  SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPasswordController),
                  SizedBox(height: 10),
                  const SizedBox(height: 30),
                  MyButton(
                    text: 'Sign Up',
                    onTap: () async {
                      await signUpController.signUp(
                          emailAddress: emailController.text,
                          password: passwordController.text);
                      Get.toNamed(AppRoutes.homeScreen);
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.loginScreen),
                        child: Text(
                          ' Login Now',
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
          ),
        ),
      ),
    );
  }
}
