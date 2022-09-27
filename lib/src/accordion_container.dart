import 'package:expanded_accordion/src/accordion_header.dart';
import 'package:expanded_accordion/src/accordion_header_container.dart';
import 'package:expanded_accordion/src/expansion_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AccordionContainer extends StatefulWidget {
  final AccordionHeaderContainer header;
  final Widget content;
  final BoxDecoration? decoration;
  ExpansionController? controller;

  AccordionContainer(
      {Key? key, required this.header, required this.content, this.decoration})
      : super(key: key);

  @override
  State<AccordionContainer> createState() => _AccordionContainerState();
}

class _AccordionContainerState extends State<AccordionContainer> {
  var headerKey = GlobalKey();
  late ExpansionController controller;
  Size? size;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    super.initState();

    if (widget.controller == null) {
      controller = ExpansionController();
    } else {
      controller = widget.controller!;
    }

    controller.addListener(() {
      setState(() {});
    });
  }

  void postFrameCallback(_) {
    var context = headerKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    debugPrint(
        " ${headerKey.toString()} Size ${newSize?.height} * ${newSize?.width}");

    if (newSize != null) {
      controller.addItemWidget(headerKey, newSize.height);
      size = newSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ??
        BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14));
    return AnimatedContainer(
      height: controller.expandedKey == headerKey
          ? controller.expandSize
          : size?.height ?? 0,
      clipBehavior: Clip.hardEdge,
      decoration: decoration,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AccordionHeader(
              key: headerKey,
              controller: controller,
              title: widget.header.title,
              icon: widget.header.icon,
              color: widget.header.color),
          Expanded(child: widget.content)
        ],
      ),
    );
  }
}
