import 'package:flutter/material.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_list.dart';
import 'core/constants/app_theme.dart';
import 'core/router/router_imports.dart';
import 'core/router/router_paths.dart';
import 'flavor_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.locale});
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: AppFlavor.env == Env.dev ? true : false,
          title: AppLocalizations.of(context)?.appName ?? '',
          navigatorKey: Get.key,
          theme: AppThemes.lightTheme,
          themeMode: ThemeMode.light,
          initialRoute: RouterPaths.initializer,
          getPages: GeneratedPages.pages,
          locale: Get.locale ?? locale,
          supportedLocales: AppList.localeList,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
