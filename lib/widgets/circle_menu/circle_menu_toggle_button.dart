
import 'package:flutter/material.dart';


class CircleMenuToggleButton extends StatefulWidget {
  final bool expanded;
  CircleMenuToggleButton({this.expanded = false});

  @override
  State<StatefulWidget> createState() {
    return _CircleMenuToggleButtonState();
  }
}

class _CircleMenuToggleButtonState extends State<CircleMenuToggleButton>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  // final bubbles = <Bubble>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            widget.expanded
                ? 'assets/buttons/close_menu.png'
                : 'assets/buttons/add_drink.png',
            width: 50.0,
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
