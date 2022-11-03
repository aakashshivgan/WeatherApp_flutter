import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_getx/controller/global_controller.dart';
import 'package:weather_app_getx/model/weather_data_hourly.dart';
import 'package:weather_app_getx/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  // card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 2,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                      color: CustomColors.dividerLine.withAlpha(200),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0.5, 0),
                            blurRadius: 30,
                            spreadRadius: 1,
                            color: CustomColors.dividerLine.withAlpha(20))
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])
                          : null),
                  child: HourlyDetials(
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    temp: weatherDataHourly.hourly[index].temp!,
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              ));
        },
      ),
    );
  }
}

// hourly detials class
class HourlyDetials extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetials(
      {super.key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.all(5),
          child: Image.asset("assets/weather/$weatherIcon.png"),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        )
      ],
    );
  }
}
