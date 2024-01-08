import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_days_forecast/routes/routes.dart';
import 'package:five_days_forecast/constants/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../constants/constant_widgets.dart';




class WeatherAppController extends GetxController {

  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  RxBool currentWeatherView = true.obs;

  RxList cityList = [].obs;

  RxBool isLoading = true.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  loginAccount() async{
    String userName = usernameController.text.trim();
    String passWord = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userName,
          password: passWord
      );
      Get.toNamed(Routes.HOME_SCREEN);
    }on FirebaseAuthException catch(ex){
      errorSnackBar(message: ex.code.trim());
    }
  }

  logout() async{
    if(isInternetAvailable.value){
      try {
        await FirebaseAuth.instance.signOut();
      }on FirebaseAuthException catch(ex){
        errorSnackBar(message: ex.code.trim());
      }
    }
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

}






