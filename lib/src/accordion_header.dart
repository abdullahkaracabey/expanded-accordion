import 'package:expanded_accordion/src/expansion_controller.dart';
import 'package:flutter/material.dart';

class AccordionHeader extends StatelessWidget {
  final Widget title;
  final Widget? icon;
  final Color? color;
  final ExpansionController controller;

  const AccordionHeader(
      {Key? key,
      required this.controller,
      required this.title,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.expandedKey = key,
      child: Container(
        color: color ?? Colors.white,
        child: Row(
          children: [
            Expanded(child: title),
            AnimatedRotation(
              turns: controller.expandedKey == key ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: icon ?? const Icon(Icons.arrow_drop_down_sharp),
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
      ),
    );
  }
}
