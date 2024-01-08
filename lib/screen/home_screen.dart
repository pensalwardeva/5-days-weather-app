import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_days_forecast/routes/routes.dart';
import 'package:five_days_forecast/constants/string_constants.dart';
import 'package:five_days_forecast/custom%20textfield/text_field.dart';
import 'package:five_days_forecast/custom%20textfield/text_styles.dart';
import 'package:five_days_forecast/firebase%20option/weather_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';
import 'package:weather/weather.dart';

import '../asset/assets.dart';
import '../colors custom/app_colors.dart';
import '../constants/constant_widgets.dart';
import '../custom buttons/button.dart';
import '../netwoek/network_controller.dart';




enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

void main() => runApp(const HomeScreen());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  NetworkController networkController =
      Get.put(NetworkController(), permanent: true);
  WeatherAppController weatherAppController = Get.find();

  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  late Position position;

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(key);
    currentPosition();
  }

  currentPosition() async {
    position = await weatherAppController.determinePosition();
    queryWeather();
  }

  void queryForecast() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });
    List<Weather> forecasts = await ws
        .fiveDayForecastByCityName(weatherAppController.searchController.text);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });
    Weather weather = await ws.currentWeatherByLocation(
        position.latitude, position.longitude);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeatherByCity() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws
        .currentWeatherByCityName(weatherAppController.searchController.text);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child:
      weatherAppController.currentWeatherView.value ? currentWeatherView(_data.first.areaName!,_data.first.temperature!.toString(),_data.first.weatherDescription!)
          :ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          String formattedDate =
              DateFormat('EEEE, MMMM d y, hh:mm a').format(_data[index].date!);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _data[index].areaName!.toString(),
                            style: TextHelper.size20,
                          ),
                          SizedBox(
                              width: 35.w,
                              child: Text(
                                formattedDate,
                                style: TextHelper.size13,
                              )),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _data[index].temperature!.toString(),
                          style: TextHelper.size20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              weatherImages(
                                  _data[index].weatherDescription!.toString()),
                              height: 30,
                            ),
                            width(3.w),
                            Text(_data[index].weatherDescription!.toString()),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget contentDownloading() {

    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        weatherAppController.isLoading.value = false;
      });
    });

    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          Visibility(
            visible: weatherAppController.isLoading.value,
            child: Column(children: [
              const Text(
                'Fetching Weather...',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  child:  Center(
                          child: const CircularProgressIndicator(strokeWidth: 5)
                      )
              )
            ]),
          ),
          Visibility(
            visible: !weatherAppController.isLoading.value,
            child:  Column(children: [
              Text(
                'City data not found please search another city.',
                style: TextHelper.size15,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget contentNotDownloaded() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Please wait...',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsForApp.primaryColor,
        title: const Text('Weather App'),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              SystemNavigator.pop();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomTextField(
                  controller: weatherAppController.searchController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Enter City Name',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                  textInputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CommonButton(
                    onPressed: () {
                      if (weatherAppController.searchController.text.isEmpty) {
                        errorSnackBar(message: "Please enter city name");
                      } else {
                        weatherAppController.currentWeatherView.value = true;
                        weatherAppController.isLoading.value = true;
                        queryWeatherByCity();
                      }
                    },
                    label: "Search"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                child: CommonButton(
                    onPressed: () {
                      if (weatherAppController.searchController.text.isEmpty) {
                        errorSnackBar(message: "Please enter city name");
                      } else {
                        weatherAppController.currentWeatherView.value = false;
                        weatherAppController.isLoading.value = true;
                        queryForecast();
                      }
                    },
                    label: "Forecast"),
              ),
              const Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              Expanded(child: _resultView())
            ],
          ),
      ),
    );
  }

  Widget currentView() {
    return Column(
      children: [Image.asset(Assets.imagesWeatherApp)],
    );
  }

  weatherImages(String weather) {
    if (weather == "broken clouds") {
      return Assets.imagesCloudy;
    } else if (weather == "clear sky") {
      return Assets.imagesSun;
    } else if (weather == "few clouds") {
      return Assets.imagesFewclouds;
    } else if (weather == "scattered clouds") {
      return Assets.imagesScatteredCloud;
    } else if (weather == "overcast clouds") {
      return Assets.imagesOvercastCloud;
    } else {
      return Assets.imagesCloudy;
    }
  }

  currentWeatherView(String  city, String temp, String description) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: ColorsForApp.primaryColor,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            city,
            style: const TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            temp,
            style: TextStyle(fontSize: 45, color: Colors.white.withOpacity(0.5)),
          ),
          Image.asset(weatherImages(description),height: 20.h,),
          Text(
            description,
            style: TextStyle(fontSize: 45, color: Colors.white.withOpacity(0.5)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CommonButton(
              bgColor: ColorsForApp.shadowColor,
                onPressed: (){
                    customSimpleDialog(
                        context: context,
                      title: Text("Add City"),
                      description: Text("You want to add this in favourite list"),
                      onYes: (){
                          Get.back();
                          weatherAppController.cityList.add(city);
                          Get.toNamed(Routes.FAV_CITY_LIST);
                      }
                    );
                },
                label: "Add to favourite"
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CommonButton(
              bgColor: ColorsForApp.shadowColor,
                onPressed: (){
                  Get.toNamed(Routes.FAV_CITY_LIST);
                },
                label: "View favourite cities"
            ),
          ),
        ]),
      ),
    );
  }
}
