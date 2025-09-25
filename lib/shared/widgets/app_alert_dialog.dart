part of 'widget_imports.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    this.iconData,
    required this.title,
    required this.message,
    required this.primaryButtonText,
    this.secondaryButtonText,
    required this.buttonAction,
    this.themeColor = AppColors.primaryColor,
    this.buttonLoading = false,
    this.hideSecondaryButton = false,
  });
  final IconData? iconData;
  final String title;
  final String message;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final Function() buttonAction;
  final Color themeColor;
  final bool buttonLoading;
  final bool hideSecondaryButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(12),
      backgroundColor: AppColors.lightCardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Icon
          CircleAvatar(
            radius: 30,
            backgroundColor: themeColor.withAlpha(38),
            child: Icon(iconData ?? Icons.error, size: 36, color: themeColor),
          ).paddingOnly(bottom: 10),
          //Title
          TitleText(text: title).paddingOnly(bottom: 4),
          //Warning Message
          SmallText(text: message, textAlign: TextAlign.center).paddingOnly(bottom: 20),

          //Button
          hideSecondaryButton
              ? SolidTextButton(
                  buttonText: primaryButtonText,
                  onTap: buttonAction,
                  isLoading: buttonLoading,
                  backgroundColor: themeColor,
                )
              : Row(
                  children: [
                    Expanded(
                      child: OutlineTextButton(
                        buttonText: secondaryButtonText ?? '${AppLocalizations.of(context)?.cancel}',
                        onTap: () => Get.back(),
                      ),
                    ),
                    const WidthBox(width: 8),
                    Expanded(
                      child: SolidTextButton(
                        buttonText: primaryButtonText,
                        onTap: buttonAction,
                        isLoading: buttonLoading,
                        backgroundColor: themeColor,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
