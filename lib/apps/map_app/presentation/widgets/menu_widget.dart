import 'dart:ui';

import 'package:flutter/material.dart';

class FoldableMenu extends StatefulWidget {
  const FoldableMenu({super.key, required this.onBackPressed});
  final Function() onBackPressed;
  @override
  State<FoldableMenu> createState() => _FoldableMenuState();
}

class _FoldableMenuState extends State<FoldableMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) => BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 2 * controller.value, sigmaY: 2 * controller.value),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 150 * controller.value + 50,
                  height: 350 * controller.value + 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Center(
                    child: TextButton(
                        onPressed: widget.onBackPressed,
                        child: const Text(
                          "Back",
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          softWrap: false,
                        )),
                  ),
                ),
              ),
            ));
  }
}
