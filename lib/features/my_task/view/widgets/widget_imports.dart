import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/extensions/int_extension.dart';
import '../../../../features/my_task/model/task_overview_model.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/repository/local/date_time_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/my_task_controller.dart';
import '../../model/time_slot_model.dart';

part 'home_calender_widget.dart';
part 'home_header_widget.dart';
part 'home_task_card.dart';
part 'task_filter_dropdown.dart';
part 'time_slot_dropdown.dart';
part 'home_event_calender_widget.dart';
