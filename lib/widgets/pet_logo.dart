import 'package:flutter/material.dart';

import '../core/constants/app_assets.dart';

class PetLogo extends StatelessWidget {
  const PetLogo({super.key, this.size = 184, this.orangeOnWhite = true});

  final double size;
  final bool orangeOnWhite;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splashLogo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
    );
  }
}
