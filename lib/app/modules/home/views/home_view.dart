import 'package:bhumibd/app/data/end_point/api.dart';
import 'package:bhumibd/app/resource/widget/custom_web_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: CustomWebView(url: appApi.baseUrl)),
    );
  }
}
