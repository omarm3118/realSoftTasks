import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/util/app_constants.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
              color: AppConstants.defaultPurple,
              gradient: LinearGradient(
                  colors: [AppConstants.defaultPurple, Colors.white],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        Lottie.asset('assets/images/purple.json', animate: true),
      ],
    );
  }
}
