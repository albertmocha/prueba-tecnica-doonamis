import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TextBgRoundedFill extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final double altura;
  final Color textColor;
  final double paddingLateral;
  final VoidCallback? onTap;
  const TextBgRoundedFill({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    required this.backgroundColor,
    required this.altura,
    this.textColor = AppColors.scaffoldColor,
    this.paddingLateral = 20,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            onTap: onTap,
            child: Ink(
              height: altura,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(35.0)),
              ),
              child: Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingLateral),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
