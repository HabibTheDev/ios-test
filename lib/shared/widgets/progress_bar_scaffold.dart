part of 'widget_imports.dart';

class ProgressBarScaffold extends StatelessWidget {
  const ProgressBarScaffold(
      {super.key, required this.title, this.subTitle, required this.progressValue, required this.body});
  final String title;
  final String? subTitle;
  final double progressValue;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        titleSpacing: -8,
        title: SizedBox(
          width: width * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonText(
                  text: title, textColor: AppColors.lightAppBarIconColor, maxLines: 1, overflow: TextOverflow.ellipsis),
              if (subTitle != null)
                SmallText(
                  text: subTitle!,
                  textColor: AppColors.lightAppBarIconColor,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                )
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: width * .32,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: LinearProgressIndicator(
                value: progressValue,
                color: AppColors.lightProgressColor,
                minHeight: 8,
                backgroundColor: AppColors.lightProgressTrackColor,
              ),
            ),
          ).paddingOnly(right: 4),
          BodyText(
            text: '${(progressValue * 100).round()}%',
            textColor: AppColors.lightAppBarIconColor,
          ).paddingOnly(right: 16)
        ],
      ),
      body: body,
    );
  }
}
