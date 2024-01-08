import 'package:five_days_forecast/firebase%20option/weather_app_controller.dart';
import 'package:get/get.dart';

class WeatherAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherAppController>(() => WeatherAppController());
  }
}
