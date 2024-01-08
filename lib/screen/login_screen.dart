

import 'package:five_days_forecast/constants/string_constants.dart';
import 'package:five_days_forecast/custom%20textfield/text_field.dart';
import 'package:five_days_forecast/custom%20textfield/text_styles.dart';
import 'package:five_days_forecast/firebase%20option/weather_app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../colors custom/app_colors.dart';
import '../asset/assets.dart';
import '../custom buttons/button.dart';
import '../constants/constant_widgets.dart';
import '../netwoek/network_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  NetworkController networkController = Get.put(NetworkController(), permanent: true);
  WeatherAppController weatherAppController = Get.find();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: weatherAppController.loginForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image.asset(Assets.imagesWeatherApp,height: 30.h,),
                  Text("Weather App",style: TextHelper.size20.copyWith(fontSize: 25,color: ColorsForApp.primaryColor,fontWeight: FontWeight.bold),),
                  Text("Weather App",style: TextHelper.size20.copyWith(fontSize: 25,color: ColorsForApp.primaryColor,fontWeight: FontWeight.bold),),
                  height(20),
                  CustomTextField(
                    controller: weatherAppController.usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    // validator: (value) {
                    //   if (value!.trim().isEmpty) {
                    //     return 'Please enter email';
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  height(20),
                  CustomTextField(
                    controller: weatherAppController.passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    // validator: (value) {
                    //   if (value!.trim().isEmpty) {
                    //     return 'Please enter password';
                    //   }
                    //   return null;
                    // },
                    obscureText: true,
                  ),
                  height(20),
                 CommonButton(
                     onPressed: () async {
                       if(weatherAppController.loginForm.currentState!.validate()){
                         if(isInternetAvailable.value){
                           await weatherAppController.loginAccount();
                         }else{
                            errorSnackBar(message: "Please check our internet connection");
                         }
                       }
                     },
                     label: "Login"
                 )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
