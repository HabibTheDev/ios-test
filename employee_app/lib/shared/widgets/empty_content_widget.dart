part of 'widget_imports.dart';

class EmptyContentWidget extends StatelessWidget {
  const EmptyContentWidget({super.key, this.title, this.subTitle, this.svgAsset});
  final String? svgAsset;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (svgAsset != null) SvgPicture.asset(svgAsset!).paddingOnly(bottom: 10),
          if (title != null) TitleText(text: title!, textAlign: TextAlign.center),
          if (subTitle != null)
            SmallText(text: subTitle!, textColor: AppColors.lightSecondaryTextColor, textAlign: TextAlign.center)
        ],
      ).paddingAll(16),
    );
  }
}
