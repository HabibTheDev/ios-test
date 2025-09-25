part of 'widget_imports.dart';

class TextFormFieldWithLabel extends StatefulWidget {
  const TextFormFieldWithLabel(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      this.onTap,
      this.obscure = false,
      this.readOnly = false,
      this.required = false,
      this.textInputType,
      this.textCapitalization,
      this.inputFormatters,
      this.textAlign = TextAlign.left,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixWidget,
      this.suffixColor,
      this.prefixColor,
      this.maxLine,
      this.minLine,
      this.validationErrorMessage,
      this.maxLength,
      this.suffixOnTap,
      this.prefixOnTap,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.focusNode});

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Color? suffixColor;
  final Color? prefixColor;
  final TextAlign? textAlign;
  final bool obscure;
  final bool required;
  final bool readOnly;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final String? validationErrorMessage;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? suffixOnTap;
  final Function()? prefixOnTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<TextFormFieldWithLabel> createState() => _TextFormFieldWithLabelState();
}

class _TextFormFieldWithLabelState extends State<TextFormFieldWithLabel> {
  bool _obscure = true;
  String? _errorMessage;
  final _debounceRepo = ServiceLocator.get<DebounceRepo>();

  @override
  void dispose() {
    _debounceRepo.dispose();
    super.dispose();
  }

  String? _validateInput(String? value, AppLocalizations? locale) {
    if (value == null) {
      setState(() => _errorMessage = null);
      return _errorMessage;
    }
    if (widget.required) {
      if (value.isEmpty) {
        setState(() => _errorMessage = "${widget.labelText} ${locale?.canNotEmpty}");
        return _errorMessage;
      } else if (widget.textInputType == TextInputType.emailAddress && !value.isValidEmail) {
        setState(() => _errorMessage = '${locale?.invalidEmailAddress}');
        return _errorMessage;
      } else if (widget.textInputType == TextInputType.phone && !value.isValidPhone) {
        setState(() => _errorMessage = '${locale?.invalidPhoneNumber}');
        return _errorMessage;
      } else if (widget.textInputType == TextInputType.visiblePassword && !value.isValidPassword) {
        setState(() => _errorMessage = '${locale?.passwordValidation}');
        return _errorMessage;
      } else {
        setState(() => _errorMessage = null);
        return _errorMessage;
      }
    } else {
      setState(() => _errorMessage = null);
      return _errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SmallText(
          text: widget.labelText,
          fontWeight: FontWeight.w600,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 4),
        TextFormField(
          validator: (value) => _validateInput(value, locale),
          controller: widget.controller,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          onChanged: (value) {
            _debounceRepo.debounce(() => _validateInput(value, locale), delayMilliseconds: 300);
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
            return null;
          },
          onEditingComplete: widget.onEditingComplete,
          readOnly: widget.readOnly,
          obscureText: widget.obscure ? _obscure : false,
          keyboardType: widget.textInputType ?? TextInputType.text,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLine ?? 1,
          minLines: widget.minLine ?? 1,
          textAlign: widget.textAlign!,
          style: const TextStyle(color: AppColors.lightTextColor, fontWeight: FontWeight.w400, fontSize: 16),
          decoration: InputDecoration(
              errorMaxLines: 5,
              errorText: widget.validationErrorMessage ?? _errorMessage,
              alignLabelWithHint: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
              isDense: true,
              fillColor: AppColors.lightTextFieldFillColor,
              filled: true,
              contentPadding: widget.contentPadding ?? const EdgeInsets.all(12),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle:
                  const TextStyle(color: AppColors.lightTextFieldHintColor, fontWeight: FontWeight.w400, fontSize: 16),
              prefixIcon: widget.prefixIcon,
              suffixIconConstraints: BoxConstraints.loose(size),
              prefixIconConstraints: BoxConstraints.loose(size),
              suffix: widget.suffixWidget,
              suffixIcon: widget.obscure
                  ? InkWell(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(_obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                            size: 20, color: widget.suffixColor ?? AppColors.lightTextFieldHintColor),
                      ),
                    )
                  : InkWell(
                      onTap: widget.suffixOnTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          widget.suffixIcon,
                          size: 20,
                          color: widget.suffixColor ?? AppColors.lightTextFieldHintColor,
                        ),
                      ),
                    )),
        ),
      ],
    );
  }
}
