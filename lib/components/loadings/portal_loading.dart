import 'package:flutter/material.dart';
import 'dart:math' as math;

Future<void> showLoadingPortal(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return PortalLoading();
    },
  );
}

class PortalLoading extends StatefulWidget {
  const PortalLoading({Key? key}) : super(key: key);

  @override
  _PortalLoadingState createState() => _PortalLoadingState();
}

class _PortalLoadingState extends State<PortalLoading>
    with TickerProviderStateMixin {
  late AnimationController controllerBottom;
  late AnimationController controllerTop;

  @override
  void initState() {
    super.initState();
    controllerBottom = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    controllerTop = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    controllerBottom.dispose();
    controllerTop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: controllerBottom,
            builder: (_, child) {
              return Transform.rotate(
                angle: controllerBottom.value * 2 * math.pi,
                child: Image.asset('assets/images/loading_bottom.png'),
              );
            },
          ),
          AnimatedBuilder(
            animation: controllerTop,
            builder: (_, child) {
              return Transform.rotate(
                angle: controllerTop.value * 2 * math.pi,
                child: Image.asset('assets/images/loading_top.png'),
              );
            },
          ),
        ],
      ),
    );
  }
}
