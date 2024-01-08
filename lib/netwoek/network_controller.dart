import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:five_days_forecast/routes/routes.dart';
import 'package:five_days_forecast/constants/string_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/constant_widgets.dart';


class NetworkController extends GetxController {
  RxInt connectionStatus = 0.obs;
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    try {
      ConnectivityResult connectivityResult = await connectivity.checkConnectivity();
      isInternetAvailable.value = connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
      callStreamSubscription();
    } on PlatformException catch (e) {
      errorSnackBar(message: e.message);
    }
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  callStreamSubscription() {
    streamSubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      try {
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          isInternetAvailable.value = true;
          log('🛜 => 🟢');
        } else if (connectivityResult == ConnectivityResult.none) {
          isInternetAvailable.value = false;
          log('🛜 => 🔴');
        } else {
          throw Exception('Network Error, Try after sometime!');
        }

        if (isInternetAvailable.value) {
          Get.back();
        } else {
          Get.toNamed(Routes.NO_INTERNET_CONNECTION_SCREEN);
        }
      } catch (e) {
        errorSnackBar(message: e.toString());
      }
    });
  }
}
