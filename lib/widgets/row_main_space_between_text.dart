import 'package:flutter/material.dart';

class RowMainSpaceBetweenText extends StatelessWidget {
  final String left;
  final String right;
  const RowMainSpaceBetweenText({
    required this.left,
    required this.right,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(children: [
          Expanded(
            child: Text(
              left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(right, style: Theme.of(context).textTheme.bodyLarge)
        ]));
  }
}
