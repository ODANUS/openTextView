import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class HeroPopup {
  HeroPopup();

  static open({required Widget child, String? tag}) {
    Navigator.push(Get.context!, HeroDialogRoute(builder: (context) {
      return Center(
          child: Hero(
              tag: tag ?? "",
              child: Material(
                  type: MaterialType.transparency, // likely needed
                  child: child)));
      // );
    }));
  }
  // final WidgetBuilder builder;
  // final List<Widget> children;
  // final Widget title;
  // final TextStyle titleTextStyle;
  // final String tag;
  // final Function callback;
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black45;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => null;
}
