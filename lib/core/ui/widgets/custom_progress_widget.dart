import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key});

  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat(reverse: true);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Opacity(
              opacity: controller.value,
              child: const SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  image: AssetImage("assets/images/logo_flat.png"),
                ),
              )),
        ),
      ),
    ));
  }
}
