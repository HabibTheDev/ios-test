import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/start_rating_builder.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/explore_car_details_model.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.model});
  final CustomerFeedback model;

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      contentPadding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Name, date & star
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                child: Icon(
                  Icons.person,
                  color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                  size: 24,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(
                      text: model.customer?.name ?? 'N/A',
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                    ExtraSmallText(
                      text: DateFormat(AppString.readableDateFormat).format(model.createdAt ?? DateTime.now()),
                      textColor: AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ).paddingOnly(left: 8),
              ),
              SmallText(
                text: '${model.rating ?? 0.0} ',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w500,
              ),
              StartRatingBuilder(
                rating: double.parse('${model.rating ?? '0.0'}'),
                starSize: 12,
              )
            ],
          ).paddingOnly(bottom: 10),

          // Review
          SmallText(
            text: '“${model.message ?? 'N/A'}”',
            textAlign: TextAlign.start,
            textColor: AppColors.lightSecondaryTextColor,
          ),
        ],
      ),
    );
  }
}
