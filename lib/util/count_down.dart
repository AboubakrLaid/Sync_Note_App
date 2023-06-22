import 'package:flutter/material.dart';
import 'package:sync_note/util/export.dart';

typedef deleteCallBack = void Function();

class CountDown extends StatefulWidget {
  const CountDown({super.key, required this.deleteFunction});
  final deleteCallBack deleteFunction;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..reverse(from: 1);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.deleteFunction();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              color: const Color.fromRGBO(79, 75, 189, 1),
              strokeWidth: 2.5,
              value: _animationController.value,
            ),
            Text(
              "${(_animationController.value * 5).ceil()}",
              style: context.theme.textTheme.labelSmall,
            ),
          ],
        );
      },
    );
  }
}
