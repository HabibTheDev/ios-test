import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_string.dart';
import '../extensions/validator_extension.dart';
import '../../core/constants/app_color.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onTap,
      this.obscure = false,
      this.readOnly = false,
      this.required = false,
      this.textInputType,
      this.textCapitalization,
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
      this.focusNode,
      this.fillColor});

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
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
  final Color? fillColor;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      validator: (value) {
        if (widget.required && value != null && value.isEmpty) {
          return "${widget.hintText} ${AppString.canNotEmpty}";
        } else if (widget.required &&
            value != null &&
            widget.textInputType == TextInputType.emailAddress &&
            !value.isValidEmail) {
          return AppString.invalidEmailAddress;
        } else if (widget.required &&
            value != null &&
            widget.textInputType == TextInputType.phone &&
            !value.isValidPhone) {
          return AppString.invalidPhone;
        } else {
          return null;
        }
      },
      controller: widget.controller,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
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
      maxLines: widget.maxLine ?? 1,
      minLines: widget.minLine ?? 1,
      textAlign: widget.textAlign!,
      style: const TextStyle(color: AppColors.lightTextColor, fontWeight: FontWeight.w400, fontSize: 16),
      decoration: InputDecoration(
        errorText: widget.validationErrorMessage,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        fillColor: widget.fillColor ?? AppColors.lightTextFieldFillColor,
        filled: true,
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(12),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: const TextStyle(color: AppColors.lightTextFieldHintColor, fontWeight: FontWeight.w400, fontSize: 16),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: BoxConstraints.loose(size),
        prefixIconConstraints: BoxConstraints.loose(size),
        suffix: widget.suffixWidget,
        suffixIcon: widget.suffixWidget == null
            ? widget.obscure
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
                  )
            : const SizedBox.shrink(),
      ),
    );
  }
}
