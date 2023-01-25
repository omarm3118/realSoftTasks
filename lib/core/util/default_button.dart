import 'package:chat_app/core/util/app_constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final TextStyle? labelStyle;

  const DefaultButton(
      {Key? key, required this.label, required this.onPressed, this.labelStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: AppConstants.defaultPurple,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: labelStyle
        ),
      ),
    );
  }
}