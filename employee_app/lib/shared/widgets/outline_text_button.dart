part of 'widget_imports.dart';

class OutlineTextButton extends StatelessWidget {
  const OutlineTextButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.primaryColor,
    this.backgroundColor,
    this.borderRadius,
    this.fixedSize,
    this.minimumSize,
    this.maximumSize,
    this.splashColor,
    this.textColor,
    this.isLoading = false,
  });

  final Function() onTap;
  final String buttonText;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;
  final Color? primaryColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? splashColor;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                elevation: 0.0,
                fixedSize: fixedSize ?? Size(MediaQuery.of(context).size.width, 40),
                minimumSize: minimumSize ?? Size(MediaQuery.of(context).size.width, 40),
                side: BorderSide(color: primaryColor ?? AppColors.lightOutlineButtonColor),
                shape: RoundedRectangleBorder(borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(8))))
            .copyWith(
                overlayColor: WidgetStateProperty.all(splashColor ?? AppColors.lightOutlineButtonColor.withAlpha(51))),
        onPressed: onTap,
        child: isLoading
            ? const CenterLoadingWidget(color: AppColors.primaryColor)
            : ButtonText(text: buttonText, textColor: primaryColor ?? textColor ?? AppColors.lightTextFieldHintColor));
  }
}
