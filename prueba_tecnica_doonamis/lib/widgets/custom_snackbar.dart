import 'package:flutter/material.dart';

class CustomSnackBar {
  static show(
      {required BuildContext context,
      required String text,
      Color? color,
      IconData? icon}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? Colors.grey,
        content: Row(
          children: [
            Visibility(
              visible: icon != null,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
