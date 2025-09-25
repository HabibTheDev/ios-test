import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/model/single_task/assigned_by_model.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import 'inbox.dart';

class ChatWithAdmin extends StatefulWidget {
  const ChatWithAdmin({super.key});

  @override
  State<ChatWithAdmin> createState() => _ChatWithAdminState();
}

class _ChatWithAdminState extends State<ChatWithAdmin> {
  AssignedBy? assignedBy;

  @override
  void initState() {
    super.initState();
    assignedBy = Get.arguments?[ArgumentsKey.assignedBy];
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0.0,
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              assignedBy?.profilePicture == null
                  ? Icon(Icons.account_circle, size: 36, color: AppColors.buttonTextColor)
                  : ProfilePhotoWidget(imageUrl: assignedBy?.profilePicture, imageSize: 32),
              WidthBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                    text: assignedBy?.fullName ?? '${locale?.notAvailable}',
                    textColor: AppColors.buttonTextColor,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ExtraSmallText(
                    text: assignedBy?.designation ?? '${locale?.notAvailable}',
                    textColor: AppColors.buttonTextColor,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Inbox(),
      ),
    );
  }
}
