import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';


class TextExpandableWidget extends StatelessWidget {
  const TextExpandableWidget({
    Key? key,
    required this.descriptionText,
  }) : super(key: key);

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ExpandableText(
        descriptionText,
        expandText: 'show more',
        collapseText: 'show less',
        maxLines: 2,
        linkColor: Colors.blue,
      ),
    );
  }
}
