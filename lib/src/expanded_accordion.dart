import 'package:expanded_accordion/src/accordion_container.dart';
import 'package:expanded_accordion/src/expansion_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExpandedAccordion extends StatefulWidget {
  final List<AccordionContainer> items;
  final ExpansionController? controller;
  final double marginBetweenItems;
  const ExpandedAccordion(
      {Key? key,
      required this.items,
      this.controller,
      this.marginBetweenItems = 16})
      : super(key: key);

  @override
  ExpandedAccordionState createState() => ExpandedAccordionState();
}

class ExpandedAccordionState extends State<ExpandedAccordion> {
  var key = GlobalKey();
  late ExpansionController controller;
  final widgets = <Widget>[];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    controller =
        widget.controller == null ? ExpansionController() : widget.controller!;

    controller.marginBetweenItems = widget.marginBetweenItems;
    super.initState();

    for (var element in widget.items) {
      element.controller = controller;

      widgets.addAll([
        element,
        if (element != widget.items.last)
          SizedBox(
            height: widget.marginBetweenItems,
          )
      ]);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void postFrameCallback(_) {
    var context = key.currentContext;
    if (context == null) return;

    var newSize = context.size;
    debugPrint(
        "Container ${key.toString()} Size ${newSize?.height} * ${newSize?.width}");

    if (newSize != null) {
      controller.containerHeight = newSize.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.transparent,
      constraints: const BoxConstraints.expand(),
      child: Column(
        children: widgets,
      ),
    );
  }
}
