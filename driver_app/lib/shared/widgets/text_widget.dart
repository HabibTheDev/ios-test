import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_color.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      this.overflow,
      this.textSize,
      this.fontFamily,
      this.maxLines,
      this.fontWeight});
  final String text;
  final TextAlign textAlign;
  final Color? textColor;
  final double? textSize;
  final TextOverflow? overflow;
  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: textSize ?? 20,
          overflow: overflow,
          fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
          color: textColor ?? AppColors.lightTextColor),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      this.textSize,
      this.overflow,
      this.maxLines});
  final String text;
  final double? textSize;
  final TextAlign textAlign;
  final Color? textColor;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: textSize ?? 14,
          overflow: overflow,
          fontFamily: GoogleFonts.inter().fontFamily,
          color: textColor ?? AppColors.buttonTextColor),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      this.overflow,
      this.maxLine,
      this.textSize,
      this.fontWeight});
  final String text;
  final TextAlign textAlign;
  final Color? textColor;
  final double? textSize;
  final TextOverflow? overflow;
  final int? maxLine;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: textSize ?? 14,
          color: textColor ?? AppColors.lightTextColor),
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      this.overflow,
      this.maxLine,
      this.textSize,
      this.fontWeight});
  final String text;
  final TextAlign textAlign;
  final Color? textColor;
  final double? textSize;
  final TextOverflow? overflow;
  final int? maxLine;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: textSize ?? 12,
        color: textColor ?? AppColors.lightTextColor,
      ),
    );
  }
}

class ExtraSmallText extends StatelessWidget {
  const ExtraSmallText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      this.overflow,
      this.textSize,
      this.fontWeight,
      this.maxLines});
  final String text;
  final TextAlign textAlign;
  final Color? textColor;
  final double? textSize;
  final TextOverflow? overflow;

  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: textSize ?? 10,
        color: textColor ?? AppColors.lightTextColor,
      ),
    );
  }
}
