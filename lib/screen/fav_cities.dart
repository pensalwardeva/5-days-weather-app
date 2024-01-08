import 'package:five_days_forecast/custom%20textfield/text_styles.dart';
import 'package:five_days_forecast/firebase%20option/weather_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors custom/app_colors.dart';


class FavCityList extends StatefulWidget {
  const FavCityList({super.key});

  @override
  State<FavCityList> createState() => _FavCityListState();
}

class _FavCityListState extends State<FavCityList> {
  @override
  Widget build(BuildContext context) {
    WeatherAppController weatherAppController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Cities"),
        backgroundColor: ColorsForApp.primaryColor,
      ),
      body: weatherAppController.cityList.isEmpty ?
          Center(
            child: Text("Please add cities",style: TextHelper.size14.copyWith(color: ColorsForApp.primaryColor),),
          )
          : ListView.builder(itemCount: weatherAppController.cityList.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            return Obx(()=>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title:  Text(weatherAppController.cityList[index],style: TextHelper.size20.copyWith(color: ColorsForApp.primaryColor),),
                    trailing: GestureDetector(
                      onTap: (){
                        setState(() {
                          weatherAppController.cityList.removeAt(index);
                        });
                      },
                        child: const Icon(Icons.delete,color: Colors.red,size: 20,)),
                    ),
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}
