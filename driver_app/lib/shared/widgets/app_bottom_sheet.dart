import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'text_widget.dart';

void modalBottomSheet(
    {required BuildContext context,
    String? title,
    required Widget child,
    double? height,
    bool? isScrollControlled}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled ?? true,
      builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height * .85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  BodyText(
                    text: title,
                    fontWeight: FontWeight.w600,
                    textSize: 18,
                  ).paddingOnly(left: 16, top: 16, bottom: 32),
                Expanded(child: child)
              ],
            ),
          ));
}
