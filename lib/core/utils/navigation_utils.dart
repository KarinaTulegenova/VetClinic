import 'package:flutter/material.dart';

import '../constants/app_routes.dart';

class NavigationUtils {
  const NavigationUtils._();

  static void openRoot(BuildContext context, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == route) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  static void backOrDashboard(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    openRoot(context, AppRoutes.dashboard);
  }
}
