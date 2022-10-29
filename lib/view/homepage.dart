import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx/controller/global_controller.dart';
import 'package:weather_app_getx/widgets/header_widget.dart';

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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: const [
                  SizedBox(
                    height: 30,
                  ),
                  HeaderWidget()
                ],
              ))),
      ),
    );
  }
}
