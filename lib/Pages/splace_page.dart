import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/splace_controller.dart';

class SpalcePage extends StatelessWidget {
  const SpalcePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    return Scaffold(
      body: Center(
          child: Lottie.asset(
        'assets/animation/logo.json',
        width: 200,
      )),
    );
  }
}
