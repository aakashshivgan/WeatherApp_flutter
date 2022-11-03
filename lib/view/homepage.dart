import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx/controller/global_controller.dart';
import 'package:weather_app_getx/utils/custom_colors.dart';
import 'package:weather_app_getx/widgets/comfort_level_widget.dart';
import 'package:weather_app_getx/widgets/currentWeather_widget.dart';
import 'package:weather_app_getx/widgets/daily_dataForcast_widget.dart';
import 'package:weather_app_getx/widgets/header_widget.dart';
import 'package:weather_app_getx/widgets/hourly_data_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/clouds.png",
                    height: 200,
                    width: 200,
                  ),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const HeaderWidget(),

                    //  for our current temp('current')
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather()),

                    DialyDataForCast(
                      weatherDataDaily:
                          globalController.getWeatherData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather())
                  ],
                ),
              ))),
      ),
    );
  }
}
