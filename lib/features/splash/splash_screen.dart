import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/router/router_paths.dart';
import '../../shared/widgets/widget_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      Get.offAllNamed(RouterPaths.login);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: LogoPrimary()));
  }
}
