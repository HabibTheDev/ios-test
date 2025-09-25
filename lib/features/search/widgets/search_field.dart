import 'package:flutter/material.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_color.dart';

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key,
      this.textInputType,
      this.textAlign,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.hintText,
      this.focusNode});

  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final FocusNode? focusNode;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      controller: _textEditingController,
      focusNode: widget.focusNode,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
        setState(() {});
      },
      onEditingComplete: widget.onEditingComplete,
      keyboardType: widget.textInputType ?? TextInputType.text,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: const TextStyle(color: AppColors.lightTextColor, fontWeight: FontWeight.w400, fontSize: 16),
      decoration: InputDecoration(
          fillColor: AppColors.lightCardColor,
          filled: true,
          alignLabelWithHint: true,
          border:
              const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
          enabledBorder:
              const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
          focusedBorder:
              const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
          errorBorder:
              const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
          isDense: true,
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: widget.hintText ?? '${AppLocalizations.of(context)?.searchHere}',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle:
              const TextStyle(color: AppColors.lightTextFieldHintColor, fontWeight: FontWeight.w300, fontSize: 16),
          prefixIcon: _textEditingController.text.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(right: 8, left: 10),
                  child: Icon(Icons.search, size: 20, color: AppColors.lightTextFieldHintColor),
                )
              : null,
          suffixIconConstraints: BoxConstraints.loose(size),
          prefixIconConstraints: BoxConstraints.loose(size),
          suffixIcon: InkWell(
            onTap: () {
              _textEditingController.clear();
              setState(() {});
              widget.onChanged!(_textEditingController.text);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                _textEditingController.value.text.isNotEmpty ? Icons.close : null,
                size: 20,
                color: AppColors.lightTextFieldHintColor,
              ),
            ),
          )),
    );
  }
}
