import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../shared/model/single_task/steps_model.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../shared/model/single_task_model.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/maintenance_controller.dart';
import '../tiles/document_tile.dart';
import 'damage_repairing_checklist_widget.dart';
import 'regular_servicing_checklist_widget.dart';

part '../../../../shared/tiles/car_info_tile.dart';
part 'regular_damage_widget.dart';
part 'retrieve_damage_widget.dart';
part 'maintenance_car_details_widget.dart';
part 'dropoff_damage_widget.dart';
