import 'package:flutter/material.dart';

import '../../../shared/widgets/logo_primary.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LogoPrimary(),
      ),
    );
  }
}
