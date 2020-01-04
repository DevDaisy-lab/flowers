import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FadePageRoute extends MaterialPageRoute {
  FadePageRoute(
      {@required WidgetBuilder builder, @required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
