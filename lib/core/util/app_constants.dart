import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/chats/presentation/pages/dashboard_page.dart';

class AppConstants {
  static const statusBarColor = SystemUiOverlayStyle(
    statusBarColor: defaultPurple,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static const defaultPurple = Color(0xFF93278F);
  static const defaultBackgroundPurple = Color(0xff383161);
  static const scaffoldBackgroundColor = Colors.white;

  static const double kPadding = 15;
  static const kDuration = 2;

  static const List<Color> userColors = [
    Colors.teal,
    Colors.orange,
    defaultPurple,
    Colors.pink
  ];
}

checkingDialog(ctx, String message, {bool isSuccess = false}) {
  AwesomeDialog dialog = AwesomeDialog(
    context: ctx,
    dialogType: isSuccess ? DialogType.success : DialogType.error,
    title: message,
    autoHide:
    isSuccess ? const Duration(seconds: 2) : const Duration(seconds: 4),
  );
  dialog.show().then((value) => isSuccess
      ? Navigator.pushReplacementNamed(ctx, DashBoardPage.route)
      : null);
}
