import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/repository/local/local_storage_repo.dart';
import '../../../../shared/repository/remote/auth_repo.dart';
import '../../../../shared/repository/remote/profile_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/change_password_controller.dart';
import '../../controller/customize_profile_controller.dart';
import '../../controller/more_controller.dart';
import '../../controller/profile_controller.dart';
import '../widgets/widget_imports.dart';

part 'customize_profile.dart';
part 'more.dart';
part 'my_profile.dart';
part 'change_password.dart';
part 'change_pass_otp_screen.dart';
