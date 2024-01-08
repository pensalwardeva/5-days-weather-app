
import 'package:five_days_forecast/firebase%20option/weather_app_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../main.dart';
import 'fav_cities.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../netwoek/no_internet_connection_screen.dart';
import '../routes/routes.dart';

const Transition transition = Transition.fadeIn;

class AppPages {
  static const INITIAL_ROUTE = Routes.AUTHENTICATION_WRAPPER;

  static final routes = [
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => const LoginScreen(),
      transition: transition,
      binding: WeatherAppBinding()
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => const HomeScreen(),
      transition: transition,
      binding: WeatherAppBinding()
    ),
    GetPage(
        name: Routes.NO_INTERNET_CONNECTION_SCREEN,
        page: () =>  const NoInternetConnectionScreen(),
        transition: transition,
        binding: WeatherAppBinding()
    ),
    GetPage(
        name: Routes.AUTHENTICATION_WRAPPER,
        page: () =>   AuthenticationWrapper(),
        transition: transition,
        binding: WeatherAppBinding()
    ),
    GetPage(
        name: Routes.FAV_CITY_LIST,
        page: () =>   const FavCityList(),
        transition: transition,
        binding: WeatherAppBinding()
    ),
  ];
}
